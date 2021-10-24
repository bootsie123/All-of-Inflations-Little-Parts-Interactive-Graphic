// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.symbols.PointSymbolMaker

package mb.symbols
{
    import flash.display.Sprite;
    import mb.PointStyle;
    import flash.geom.Point;

    public class PointSymbolMaker implements ISymbolMaker 
    {

        private var _container:Sprite;
        private var _vectors:IPointSource;
        private var _style:PointStyle;
        private var _cacheObj:Object;

        public function PointSymbolMaker(_arg_1:Sprite, _arg_2:IPointSource)
        {
            _container = _arg_1;
            _vectors = _arg_2;
            _cacheObj = {};
        }

        public function clearCache():*
        {
            var _local_1:String;
            var _local_2:PointSymbol;
            for (_local_1 in _cacheObj)
            {
                _local_2 = _cacheObj[_local_1];
                _local_2.destroy();
            };
            _cacheObj = {};
        }

        public function setStyle(_arg_1:PointStyle):*
        {
            _style = _arg_1;
        }

        public function recycleSymbol(_arg_1:int):*
        {
            var _local_2:PointSymbol;
            _local_2 = _cacheObj[_arg_1];
            if (_local_2)
            {
                _local_2.destroy();
                delete _cacheObj[_arg_1];
            };
        }

        public function fetchSymbolById(_arg_1:int):ISymbol
        {
            var _local_2:PointSymbol;
            var _local_3:Point;
            if (_cacheObj[_arg_1])
            {
                _local_2 = _cacheObj[_arg_1];
            }
            else
            {
                _local_3 = _vectors.fetchPointById(_arg_1);
                _local_2 = new PointSymbol(_arg_1, _local_3.x, _local_3.y);
                _cacheObj[_arg_1] = _local_2;
            };
            _local_2.embed(_container, _style);
            return (_local_2);
        }


    }
}//package mb.symbols

