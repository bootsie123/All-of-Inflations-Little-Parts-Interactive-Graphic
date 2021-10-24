// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.symbols.LegacyShapeSource

package mb.symbols
{
    import mb.Waiter;
    import mb.projections.Projection;
    import mb.ScaledBoundingBox;
    import mb.BoundingBox;

    public class LegacyShapeSource extends Waiter implements IShapeSource 
    {

        protected var _cache:ShapeCache;
        protected var _vectors:LegacySwfVectors;
        protected var _boxes:BoundingBoxCache;
        protected var _proj:Projection;

        public function LegacyShapeSource(_arg_1:String, _arg_2:Projection, _arg_3:Projection)
        {
            _proj = _arg_3;
            _vectors = new LegacySwfVectors(_arg_1, _arg_2);
            waitFor(_vectors);
            startWaiting();
        }

        public function fetchSymbolSet(_arg_1:SymbolSet):SymbolSet
        {
            var _local_2:SymbolSet;
            if (!_cache)
            {
                return (null);
            };
            return (new SymbolSet(_arg_1.getIds()));
        }

        private function clearCaches():*
        {
            _boxes = new BoundingBoxCache();
            _cache = new ShapeCache();
        }

        public function set projection(_arg_1:Projection):*
        {
            _proj = _arg_1;
            if (!ready)
            {
                return;
            };
            importShapes();
        }

        public function fetchIdsByBoundsTest(_arg_1:ScaledBoundingBox):SymbolSet
        {
            var _local_2:Array;
            if (!_boxes)
            {
                return (new SymbolSet());
            };
            if (!_arg_1.intersects(_boxes))
            {
                return (new SymbolSet());
            };
            _local_2 = _boxes.getIdsByBox(_arg_1);
            return (new SymbolSet(_local_2));
        }

        public function fetchIdsByPointTest(_arg_1:Number, _arg_2:Number):SymbolSet
        {
            var _local_3:Array;
            if (!_boxes)
            {
                return (null);
            };
            if (!_boxes.containsPoint(_arg_1, _arg_2))
            {
                return (new SymbolSet());
            };
            _local_3 = _boxes.getIdsByPoint(_arg_1, _arg_2);
            return (new SymbolSet(_local_3));
        }

        public function fetchAllIds():SymbolSet
        {
            var _local_1:Array;
            if (!_cache)
            {
                return (null);
            };
            _local_1 = _cache.getAllIds();
            return (new SymbolSet(_local_1));
        }

        public function get bounds():BoundingBox
        {
            return (_boxes);
        }

        override protected function handleReadyState():*
        {
            if (_proj)
            {
                importShapes();
            };
        }

        private function importShapes():*
        {
            var _local_1:Array;
            var _local_2:int;
            var _local_3:int;
            var _local_4:ShapeVector;
            if (!_proj)
            {
                return;
            };
            clearCaches();
            _local_1 = _vectors.extractProjectedShapes(_proj);
            _local_2 = _local_1.length;
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _local_4 = _local_1[_local_3];
                _boxes.addBox(_local_4.id, _local_4);
                _cache.addShape(_local_4);
                _local_3++;
            };
        }

        public function fetchShapeById(_arg_1:int, _arg_2:uint=0):ShapeVector
        {
            var _local_3:ShapeVector;
            return (_cache.getShape(_arg_1));
        }


    }
}//package mb.symbols

