// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.symbols.ShapeSymbolMaker

package mb.symbols
{
    import flash.display.Sprite;
    import mb.ColorScheme;

    public class ShapeSymbolMaker implements ISymbolMaker 
    {

        private var _container:Sprite;
        private var _renderedObj:Object;
        private var _vectors:IShapeSource;
        private var _style:ColorScheme;

        public function ShapeSymbolMaker(_arg_1:Sprite, _arg_2:IShapeSource)
        {
            _container = _arg_1;
            _vectors = _arg_2;
            _renderedObj = {};
        }

        public function clearCache():*
        {
            _renderedObj = {};
        }

        public function setStyle(_arg_1:ColorScheme):*
        {
            _style = _arg_1;
        }

        public function fetchSymbolById(_arg_1:int):ISymbol
        {
            var _local_2:ShapeVector;
            var _local_3:ShapeSymbol;
            if (_renderedObj[_arg_1])
            {
                return (_renderedObj[_arg_1]);
            };
            _local_2 = _vectors.fetchShapeById(_arg_1);
            _local_3 = new ShapeSymbol(_arg_1, _local_2);
            _local_3.embed(_container, _style);
            _renderedObj[_arg_1] = _local_3;
            return (_local_3);
        }


    }
}//package mb.symbols

