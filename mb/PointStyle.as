// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.PointStyle

package mb
{
    import mb.expressions.IExpression;
    import flash.display.Sprite;
    import flash.utils.getDefinitionByName;

    public class PointStyle extends ColorScheme 
    {

        protected var _sizeExp:IExpression;
        protected var _symbolLink:String;
        private var _size:Number = 0;
        protected var _sizeTransform:INumberTransform;
        protected var _sizeField:String;

        public function PointStyle(_arg_1:DataSource=null)
        {
            super(_arg_1);
        }

        public function get size():Number
        {
            var _local_1:Number;
            _local_1 = _size;
            if (_rid != -1)
            {
                if (_sizeExp)
                {
                    _local_1 = Number(_sizeExp.procRow(_rid));
                }
                else
                {
                    if (_sizeField)
                    {
                        _local_1 = _data.getNumber(_rid, _sizeField);
                    };
                };
            };
            if (_sizeTransform)
            {
                _local_1 = _sizeTransform.transform(_local_1);
            };
            return (_local_1);
        }

        public function set sizeField(_arg_1:String):*
        {
            _sizeField = _arg_1;
        }

        private function getLinkSize(_arg_1:String):Number
        {
            var _local_2:Class;
            var _local_3:Sprite;
            _local_2 = (getDefinitionByName(_arg_1) as Class);
            if (!_local_2)
            {
                return (0);
            };
            _local_3 = (new (_local_2)() as Sprite);
            return (_local_3.width);
        }

        public function set sizeExpression(_arg_1:IExpression):*
        {
            _sizeExp = _arg_1;
        }

        public function set size(_arg_1:Number):*
        {
            _size = _arg_1;
        }

        public function get haveSymbol():Boolean
        {
            return ((_symbolLink) ? true : false);
        }

        public function setSizeTransform(_arg_1:INumberTransform):*
        {
            _sizeTransform = _arg_1;
        }

        public function get symbolLink():String
        {
            return (_symbolLink);
        }

        public function get color():Number
        {
            return (this.fillColor);
        }

        public function get colored():Boolean
        {
            return (haveFill);
        }

        public function set symbolLink(_arg_1:String):*
        {
            var _local_2:Number;
            _local_2 = getLinkSize(_arg_1);
            if (_local_2 > 0)
            {
                _symbolLink = _arg_1;
            };
            if (!((_size) || (_sizeExp)))
            {
                _size = _local_2;
            };
        }

        public function get haveSizeTransform():Boolean
        {
            return ((_sizeTransform) ? true : false);
        }

        public function updateSymbolStyle(_arg_1:Sprite):*
        {
            if (haveFill)
            {
                Util.setSpriteColor(_arg_1, fillColor);
            };
        }


    }
}//package mb

