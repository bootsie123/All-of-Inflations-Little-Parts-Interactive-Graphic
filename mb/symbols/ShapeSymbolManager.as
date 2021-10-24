// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.symbols.ShapeSymbolManager

package mb.symbols
{
    import flash.display.Sprite;
    import mb.NavigationManager;
    import mb.ColorScheme;

    public class ShapeSymbolManager extends SymbolManager implements ISymbolManager 
    {

        private var _maker:ShapeSymbolMaker;
        private var _vectors:IShapeSource;
        private var _canvas:Sprite;

        public function ShapeSymbolManager(_arg_1:IShapeSource, _arg_2:NavigationManager, _arg_3:Sprite)
        {
            super(_arg_2);
            _canvas = _arg_3;
            _vectors = _arg_1;
            _maker = new ShapeSymbolMaker(_canvas, _vectors);
            _strictClipping = false;
        }

        public function clearSymbols():*
        {
            _canvas.graphics.clear();
            _maker.clearCache();
            clearStoredSymbols();
        }

        private function fetchSymbols(_arg_1:SymbolSet):SymbolSet
        {
            _arg_1.setMaker(_maker);
            return (_arg_1);
        }

        public function fetchMouseoverId():int
        {
            return (-1);
        }

        public function fetchActiveSymbols():SymbolSet
        {
            updateSymbols(_vectors);
            return (fetchSymbols(getNewSymbols()));
        }

        public function updateSymbolPlacement(_arg_1:Boolean=false):*
        {
        }

        public function setStyle(_arg_1:ColorScheme):*
        {
            _maker.setStyle(_arg_1);
        }

        public function updateSymbolStyle(_arg_1:Boolean=false):*
        {
        }

        public function fetchNewSymbols():SymbolSet
        {
            updateSymbols(_vectors);
            return (fetchSymbols(getNewSymbols()));
        }


    }
}//package mb.symbols

