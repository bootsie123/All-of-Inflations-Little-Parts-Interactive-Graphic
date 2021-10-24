// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.symbols.PointSymbolManager

package mb.symbols
{
    import flash.display.Sprite;
    import mb.easing.TweenTimer;
    import mb.NavigationManager;
    import mb.XY;
    import mb.PointStyle;
    import mb.ColorScheme;
    import mb.easing.NumberTween;
    import mb.easing.TweenMethods;

    public class PointSymbolManager extends SymbolManager implements ISymbolManager 
    {

        private var _container:Sprite;
        private var _maker:PointSymbolMaker;
        private var _easer:TweenTimer;
        private var _embeddedSymbolObj:Object;
        private var _source:PointSource;
        private var _hoverId:int = -1;

        public function PointSymbolManager(_arg_1:PointSource, _arg_2:NavigationManager, _arg_3:Sprite)
        {
            super(_arg_2);
            _container = _arg_3;
            _source = _arg_1;
            _maker = new PointSymbolMaker(_container, _source);
            _strictClipping = true;
            _easer = new TweenTimer(_container.stage.frameRate);
        }

        public function clearSymbols():*
        {
            recycleSymbols(getActiveSymbols());
            _maker.clearCache();
            clearStoredSymbols();
        }

        private function fetchSymbols(_arg_1:SymbolSet):SymbolSet
        {
            recycleSymbols(getOldSymbols());
            _arg_1.setMaker(_maker);
            return (_arg_1);
        }

        protected function recycleSymbols(_arg_1:SymbolSet):*
        {
            _arg_1.reset();
            while (_arg_1.hasNext())
            {
                _maker.recycleSymbol(_arg_1.nextId());
            };
        }

        public function fetchMouseoverId():int
        {
            var _local_1:Number;
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:int;
            var _local_5:Number;
            var _local_6:SymbolSet;
            var _local_7:PointSymbol;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:Number;
            var _local_11:Number;
            var _local_12:Number;
            _local_1 = _container.mouseX;
            _local_2 = _container.mouseY;
            _local_3 = 8;
            _local_4 = -1;
            _local_5 = 1000;
            _local_6 = getActiveSymbols();
            _local_6.setMaker(_maker);
            while (_local_6.hasNext())
            {
                _local_7 = PointSymbol(_local_6.nextSymbol());
                _local_8 = (_local_7.size / 2);
                _local_9 = _local_7.x;
                _local_10 = _local_7.y;
                if (_local_8 < _local_3)
                {
                    _local_8 = _local_3;
                };
                if (!((_local_1 < (_local_9 - _local_8)) || (_local_1 > (_local_9 + _local_8))))
                {
                    _local_11 = (((_local_9 - _local_1) * (_local_9 - _local_1)) + ((_local_10 - _local_2) * (_local_10 - _local_2)));
                    _local_12 = (_local_8 * _local_8);
                    if (_local_11 <= _local_12)
                    {
                        if (_local_11 < _local_5)
                        {
                            _local_5 = _local_11;
                            _local_4 = _local_7.id;
                        };
                    };
                };
            };
            return (_local_4);
        }

        public function fetchActiveSymbols():SymbolSet
        {
            updateSymbols(_source);
            return (fetchSymbols(getActiveSymbols()));
        }

        public function updateSymbolPlacement(_arg_1:Boolean=false):*
        {
            var _local_2:SymbolSet;
            var _local_3:XY;
            var _local_4:PointSymbol;
            _local_2 = fetchActiveSymbols();
            _local_3 = _navigation.getLayerXY();
            while (_local_2.hasNext())
            {
                _local_4 = PointSymbol(_local_2.nextSymbol());
                _local_4.updatePlacement(_local_3);
                if (_arg_1)
                {
                    _local_4.updateSize();
                };
            };
        }

        public function handleSizeTween(_arg_1:Number, _arg_2:Boolean):*
        {
            var _local_3:SymbolSet;
            var _local_4:PointSymbol;
            _local_3 = getActiveSymbols();
            while (_local_3.hasNext())
            {
                _local_4 = PointSymbol(_local_3.nextSymbol());
                _local_4.tweenSize(_arg_1, _arg_2);
            };
        }

        public function setStyle(_arg_1:ColorScheme):*
        {
            _maker.setStyle(PointStyle(_arg_1));
        }

        public function fetchNewSymbols():SymbolSet
        {
            updateSymbols(_source);
            return (fetchSymbols(getNewSymbols()));
        }

        public function updateSymbolStyle(_arg_1:Boolean=false):*
        {
            var _local_2:SymbolSet;
            var _local_3:PointSymbol;
            _local_2 = getActiveSymbols();
            while (_local_2.hasNext())
            {
                _local_3 = PointSymbol(_local_2.nextSymbol());
                _local_3.updateStyle();
                if (!_arg_1)
                {
                    _local_3.updateSize();
                };
            };
            if (_arg_1)
            {
                _easer.start(1000, new NumberTween(TweenMethods.easeOutCubic, handleSizeTween, 0, 1));
            };
        }


    }
}//package mb.symbols

