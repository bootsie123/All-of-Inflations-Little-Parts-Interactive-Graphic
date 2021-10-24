// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.symbols.PointSource

package mb.symbols
{
    import mb.Waiter;
    import mb.PointDataSource;
    import mb.projections.Projection;
    import mb.BoundingBox;
    import flash.geom.Point;
    import mb.ScaledBoundingBox;

    public class PointSource extends Waiter implements IPointSource 
    {

        protected var _cache:PointDataCache;
        protected var _data:PointDataSource;
        protected var _proj:Projection;

        public function PointSource(_arg_1:PointDataSource, _arg_2:Projection)
        {
            _proj = _arg_2;
            _data = _arg_1;
            waitFor(_arg_1);
            startWaiting();
        }

        public function fetchAllIds():SymbolSet
        {
            return (new SymbolSet(_data.getRecordIds()));
        }

        public function get bounds():BoundingBox
        {
            return (_cache);
        }

        public function set projection(_arg_1:Projection):*
        {
            _proj = _arg_1;
            if (!ready)
            {
                return;
            };
            importPointData();
        }

        public function fetchPointById(_arg_1:int):Point
        {
            var _local_2:Point;
            return (_cache.getPoint(_arg_1));
        }

        public function fetchIdsByBoundsTest(_arg_1:ScaledBoundingBox):SymbolSet
        {
            var _local_2:Array;
            if (!_cache)
            {
                return (new SymbolSet());
            };
            _local_2 = _cache.getIdsByBox(_arg_1);
            return (new SymbolSet(_local_2));
        }

        public function fetchIdsByPointTest(_arg_1:Number, _arg_2:Number):SymbolSet
        {
            var _local_3:Array;
            if (!_cache)
            {
                return (new SymbolSet());
            };
            _local_3 = _cache.getIdsByPoint(_arg_1, _arg_2);
            return (new SymbolSet(_local_3));
        }

        public function get data():PointDataSource
        {
            return (_data);
        }

        private function importPointData():*
        {
            var _local_1:Array;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:Point;
            var _local_6:Point;
            _cache = new PointDataCache();
            _local_1 = _data.getRecordIds();
            _local_2 = _local_1.length;
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _local_4 = _local_1[_local_3];
                _local_5 = _data.getLatLong(_local_4);
                _local_6 = _proj.projectFast(_local_5.y, _local_5.x);
                _cache.addPoint(_local_4, _local_6.x, _local_6.y);
                _local_3++;
            };
        }

        override protected function handleReadyState():*
        {
            importPointData();
        }


    }
}//package mb.symbols

