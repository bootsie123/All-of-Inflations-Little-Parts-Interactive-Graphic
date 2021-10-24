// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.symbols.SymbolSet

package mb.symbols
{
    import mb.expressions.IFilter;

    public class SymbolSet 
    {

        private var _ids:Array;

        private var _len:int = 0;
        private var _i:int = 0;
        private var _maker:ISymbolMaker = null;

        public function SymbolSet(_arg_1:Array=null)
        {
            if (_arg_1 == null)
            {
                _arg_1 = [];
            };
            _ids = _arg_1;
            _len = _arg_1.length;
        }

        public function setMaker(_arg_1:ISymbolMaker):*
        {
            _maker = _arg_1;
        }

        public function applyFilter(_arg_1:IFilter):*
        {
            var _local_2:Array;
            var _local_3:int;
            _local_2 = [];
            _local_3 = 0;
            while (_local_3 < _len)
            {
                if (_arg_1.haveMatch(_ids[_local_3]))
                {
                    _local_2.push(_ids[_local_3]);
                };
                _local_3++;
            };
            _ids = _local_2;
            _len = _local_2.length;
        }

        public function size():int
        {
            return (_len);
        }

        public function getIds():Array
        {
            return (_ids);
        }

        public function nextSymbol():ISymbol
        {
            if (_maker == null)
            {
                return (null);
            };
            return (_maker.fetchSymbolById(nextId()));
        }

        public function hasNext():Boolean
        {
            if (_i < _len)
            {
                return (true);
            };
            reset();
            return (false);
        }

        public function nextId():int
        {
            return (_ids[_i++]);
        }

        public function addSet(_arg_1:SymbolSet):SymbolSet
        {
            var _local_2:SymbolSet;
            var _local_3:Array;
            var _local_4:Array;
            var _local_5:SymbolSet;
            _local_2 = _arg_1.subtractSet(this);
            _local_3 = _arg_1.getIds();
            _local_4 = _ids.concat(_local_3);
            _local_5 = new SymbolSet(_local_4);
            return (_local_5);
        }

        public function subtractSet(_arg_1:SymbolSet):SymbolSet
        {
            var _local_2:Object;
            var _local_3:Array;
            var _local_4:int;
            var _local_5:SymbolSet;
            var _local_6:int;
            _local_2 = _arg_1.getIndex();
            _local_3 = [];
            _local_4 = 0;
            while (_local_4 < _len)
            {
                _local_6 = _ids[_local_4];
                if (!_local_2[_local_6])
                {
                    _local_3.push(_local_6);
                };
                _local_4++;
            };
            _local_5 = new SymbolSet(_local_3);
            return (_local_5);
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
            var _local_1:Object;
            var _local_2:int;
            _local_1 = {};
            _local_2 = 0;
            while (_local_2 < _len)
            {
                _local_1[_ids[_local_2]] = true;
                _local_2++;
            };
            return (_local_1);
        }

        public function reset():*
        {
            _i = 0;
        }


    }
}//package mb.symbols

