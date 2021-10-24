// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.IdSet

package mb
{
    import mb.expressions.IFilter;

    public class IdSet 
    {

        private var _i:int = 0;
        private var _ids:Array;

        public function IdSet(_arg_1:Array=null)
        {
            if (_arg_1 == null)
            {
                _arg_1 = [];
            };
            _ids = _arg_1;
        }

        public function getIds():Array
        {
            return (_ids);
        }

        public function applyFilter(_arg_1:IFilter):*
        {
            var _local_2:int;
            var _local_3:Array;
            var _local_4:int;
            _local_2 = _ids.length;
            _local_3 = [];
            _local_4 = 0;
            while (_local_4 < _local_2)
            {
                if (_arg_1.haveMatch(_ids[_local_4]))
                {
                    _local_3.push(_ids[_local_4]);
                };
                _local_4++;
            };
            _ids = _local_3;
        }

        public function size():int
        {
            return (_ids.length);
        }

        public function hasNext():Boolean
        {
            return (_i < _ids.length);
        }

        public function nextId():int
        {
            return (_ids[_i++]);
        }

        public function reset():*
        {
            _i = 0;
        }

        public function addSet(_arg_1:IdSet):IdSet
        {
            var _local_2:IdSet;
            var _local_3:Array;
            var _local_4:Array;
            _local_2 = _arg_1.subtractSet(this);
            _local_3 = _arg_1.getIds();
            _local_4 = _ids.concat(_local_3);
            return (new IdSet(_local_4));
        }

        public function subtractSet(_arg_1:IdSet):IdSet
        {
            var _local_2:Object;
            var _local_3:Array;
            var _local_4:int;
            var _local_5:int;
            var _local_6:IdSet;
            var _local_7:int;
            _local_2 = _arg_1.getIndex();
            _local_3 = [];
            _local_4 = _ids.length;
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _local_7 = _ids[_local_5];
                if (!_local_2[_local_7])
                {
                    _local_3.push(_local_7);
                };
                _local_5++;
            };
            _local_6 = new IdSet(_local_3);
            return (_local_6);
        }

        public function traceIds():*
        {
            var _local_1:int;
            var _local_2:int;
            _local_1 = _ids.length;
            _local_2 = 0;
            while (_local_2 < _local_1)
            {
                _local_2++;
            };
        }

        public function getIndex():Object
        {
            var _local_1:int;
            var _local_2:Object;
            var _local_3:int;
            _local_1 = _ids.length;
            _local_2 = {};
            _local_3 = 0;
            while (_local_3 < _local_1)
            {
                _local_2[_ids[_local_3]] = true;
                _local_3++;
            };
            return (_local_2);
        }


    }
}//package mb

