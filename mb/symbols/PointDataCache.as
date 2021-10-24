// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.symbols.PointDataCache

package mb.symbols
{
    import mb.BoundingBox;
    import flash.geom.Point;

    public class PointDataCache extends BoundingBox 
    {

        private static var _p:Point = new Point();

        private var _bounds:BoundingBox;
        private var _yArr:Array;
        private var _len:int = 0;
        private var _xArr:Array;
        private var _idArr:Array;

        public function PointDataCache()
        {
            _xArr = [];
            _yArr = [];
            _idArr = [];
            _bounds = new BoundingBox();
        }

        public function getIdsByBox(_arg_1:BoundingBox):Array
        {
            var _local_2:Array;
            var _local_3:int;
            var _local_4:Number;
            var _local_5:Number;
            _local_2 = [];
            _local_3 = 0;
            while (_local_3 < _len)
            {
                _local_4 = _xArr[_local_3];
                _local_5 = _yArr[_local_3];
                if (_arg_1.containsPoint(_local_4, _local_5))
                {
                    _local_2.push(_idArr[_local_3]);
                };
                _local_3++;
            };
            return (_local_2);
        }

        public function getIdsByPoint(_arg_1:Number, _arg_2:Number):Array
        {
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:int;
            var _local_6:Number;
            var _local_7:int;
            var _local_8:Number;
            if (_len <= 0)
            {
                return ([]);
            };
            _local_3 = _xArr[0];
            _local_4 = _yArr[0];
            _local_5 = _idArr[0];
            _local_6 = (((_arg_1 - _local_3) * (_arg_1 - _local_3)) + ((_arg_2 - _local_4) * (_arg_2 - _local_4)));
            _local_7 = 1;
            while (_local_7 < _len)
            {
                _local_3 = _xArr[_local_7];
                _local_4 = _yArr[_local_7];
                _local_8 = (((_arg_1 - _local_3) * (_arg_1 - _local_3)) + ((_arg_2 - _local_4) * (_arg_2 - _local_4)));
                if (_local_8 < _local_6)
                {
                    _local_6 = _local_8;
                    _local_5 = _idArr[_local_7];
                };
                _local_7++;
            };
            return ([_local_5]);
        }

        public function getPoint(_arg_1:int):Point
        {
            _p.x = _xArr[_arg_1];
            _p.y = _yArr[_arg_1];
            return (_p);
        }

        public function addPoint(_arg_1:int, _arg_2:Number, _arg_3:Number):*
        {
            _idArr[_len] = _arg_1;
            _xArr[_len] = _arg_2;
            _yArr[_len] = _arg_3;
            _len++;
            _bounds.mergePoint(_arg_2, _arg_3);
        }


    }
}//package mb.symbols

