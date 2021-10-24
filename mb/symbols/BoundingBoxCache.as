// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.symbols.BoundingBoxCache

package mb.symbols
{
    import mb.BoundingBox;

    public class BoundingBoxCache extends BoundingBox 
    {

        private var _boxes:Array;
        private var _ids:Array;

        public function BoundingBoxCache()
        {
            init();
        }

        private function init():*
        {
            _ids = [];
            _boxes = [];
        }

        public function getIdsByBox(_arg_1:BoundingBox):Array
        {
            var _local_2:int;
            var _local_3:Array;
            var _local_4:int;
            var _local_5:BoundingBox;
            _local_2 = _boxes.length;
            _local_3 = [];
            _local_4 = 0;
            while (_local_4 < _local_2)
            {
                _local_5 = _boxes[_local_4];
                if (_arg_1.intersects(_local_5))
                {
                    _local_3.push(_ids[_local_4]);
                };
                _local_4++;
            };
            return (_local_3);
        }

        public function getIdsByPoint(_arg_1:Number, _arg_2:Number):Array
        {
            var _local_3:int;
            var _local_4:Array;
            var _local_5:int;
            var _local_6:BoundingBox;
            _local_3 = _boxes.length;
            _local_4 = [];
            _local_5 = 0;
            while (_local_5 < _local_3)
            {
                _local_6 = _boxes[_local_5];
                if (_local_6.containsPoint(_arg_1, _arg_2))
                {
                    _local_4.push(_ids[_local_5]);
                };
                _local_5++;
            };
            return (_local_4);
        }

        public function addBox(_arg_1:int, _arg_2:BoundingBox):*
        {
            _ids.push(_arg_1);
            _boxes.push(_arg_2);
            merge(_arg_2);
        }


    }
}//package mb.symbols

