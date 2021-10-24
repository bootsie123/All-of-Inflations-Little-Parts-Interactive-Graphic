// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.symbols.SymbolManager

package mb.symbols
{
    import mb.NavigationManager;
    import mb.expressions.IFilter;
    import mb.ScaledBoundingBox;

    public class SymbolManager 
    {

        protected var _navigation:NavigationManager;
        private var _oldSymbols:SymbolSet;
        private var _filter:IFilter;
        private var _activeSymbols:SymbolSet;
        private var _newSymbols:SymbolSet;

        protected var _renderAll:Boolean = false;
        protected var _strictClipping:Boolean = true;

        public function SymbolManager(_arg_1:NavigationManager)
        {
            if (!_arg_1.ready)
            {
                return;
            };
            _navigation = _arg_1;
        }

        public function setFilter(_arg_1:IFilter):*
        {
            _filter = _arg_1;
        }

        protected function getNewSymbols():SymbolSet
        {
            return ((_newSymbols) ? _newSymbols : new SymbolSet());
        }

        protected function updateSymbols(_arg_1:IVectorSource):*
        {
            var _local_2:ScaledBoundingBox;
            var _local_3:SymbolSet;
            if (_renderAll)
            {
                if (!_activeSymbols)
                {
                    _activeSymbols = _arg_1.fetchAllIds();
                    if (_filter)
                    {
                        _activeSymbols.applyFilter(_filter);
                    };
                    _oldSymbols = new SymbolSet();
                    _newSymbols = _activeSymbols;
                }
                else
                {
                    if (_newSymbols.size() > 0)
                    {
                        _newSymbols = new SymbolSet();
                    };
                };
            }
            else
            {
                _local_2 = _navigation.getVisibleBounds();
                _local_3 = _arg_1.fetchIdsByBoundsTest(_local_2);
                if (_filter)
                {
                    _local_3.applyFilter(_filter);
                };
                if (_activeSymbols)
                {
                    _newSymbols = _local_3.subtractSet(_activeSymbols);
                    if (_strictClipping)
                    {
                        _oldSymbols = _activeSymbols.subtractSet(_local_3);
                        _activeSymbols = _local_3;
                    }
                    else
                    {
                        _oldSymbols = new SymbolSet();
                        _activeSymbols = _activeSymbols.addSet(_newSymbols);
                    };
                }
                else
                {
                    _newSymbols = _local_3;
                    _oldSymbols = new SymbolSet();
                    _activeSymbols = _local_3;
                };
            };
        }

        public function set renderAll(_arg_1:Boolean):*
        {
            _renderAll = _arg_1;
            clearStoredSymbols();
        }

        protected function clearFilter():*
        {
            _filter = null;
        }

        protected function getOldSymbols():SymbolSet
        {
            return ((_oldSymbols) ? _oldSymbols : new SymbolSet());
        }

        public function clearStoredSymbols():*
        {
            _activeSymbols = null;
            _newSymbols = null;
            _oldSymbols = null;
        }

        protected function getActiveSymbols():SymbolSet
        {
            return ((_activeSymbols) ? _activeSymbols : new SymbolSet());
        }


    }
}//package mb.symbols

