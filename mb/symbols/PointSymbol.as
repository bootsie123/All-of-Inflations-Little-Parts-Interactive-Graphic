// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.symbols.PointSymbol

package mb.symbols
{
    import flash.display.Sprite;
    import mb.PointStyle;
    import flash.geom.Point;
    import mb.XY;
    import mb.Util;
    import mb.ColorScheme;

    public class PointSymbol implements ISymbol 
    {

        protected static var tmpStr:String;
        protected static var _count:int = 0;

        protected var _container:Sprite;
        protected var _parent:Sprite;
        protected var _style:PointStyle;
        protected var _oldSize:Number;
        protected var _newSize:Number;
        protected var _sid:int;
        protected var _mycount:int;
        protected var _x:Number;
        protected var _y:Number;
        protected var _sp:Sprite;

        protected var _size:Number = 0;
        protected var _busyTweening:Boolean = false;
        protected var _rendered:Boolean = false;

        public function PointSymbol(_arg_1:int, _arg_2:Number, _arg_3:Number)
        {
            _sid = _arg_1;
            _x = _arg_2;
            _y = _arg_3;
            _mycount = ++_count;
        }

        protected function setPosition(_arg_1:XY):*
        {
            var _local_2:Point;
            _local_2 = _arg_1.projToScreen(_x, _y);
            _container.x = _local_2.x;
            _container.y = _local_2.y;
        }

        public function tweenSize(_arg_1:Number, _arg_2:Boolean):*
        {
            var _local_3:Number;
            if (!_busyTweening)
            {
                _oldSize = _size;
                _style.rid = _sid;
                _newSize = _style.size;
            };
            _local_3 = ((_oldSize * (1 - _arg_1)) + (_arg_1 * _newSize));
            setSize(_local_3);
            if (_arg_2)
            {
                _busyTweening = false;
            };
        }

        public function get id():int
        {
            return (_sid);
        }

        public function destroy():*
        {
            if (_container)
            {
                _container.parent.removeChild(_container);
                _container = null;
                _sp = null;
            };
        }

        public function updatePlacement(_arg_1:XY):*
        {
            var _local_2:Number;
            if (!_style)
            {
                return;
            };
            _style.rid = _sid;
            _local_2 = _style.size;
            if (!_rendered)
            {
                if (!_parent)
                {
                    return;
                };
                tmpStr = _style.symbolLink;
                if (!tmpStr)
                {
                    _sp = Util.createSprite(_parent);
                }
                else
                {
                    _sp = Util.attachLibrarySprite(tmpStr, _parent);
                    _size = _sp.width;
                    updateSize();
                };
                updateStyle();
                _container = _sp;
                _rendered = true;
            };
            if (!_container)
            {
                return;
            };
            setPosition(_arg_1);
        }

        public function get y():Number
        {
            return (_container.y);
        }

        public function updateSize():*
        {
            _style.rid = _sid;
            setSize(_style.size);
        }

        public function get size():Number
        {
            return (_size);
        }

        public function updateStyle():*
        {
            _style.rid = _sid;
            _style.updateSymbolStyle(_sp);
        }

        protected function setSize(_arg_1:Number):*
        {
            var _local_2:Number;
            var _local_3:Number;
            _local_2 = _size;
            _local_3 = (_local_2 - _arg_1);
            if (((_local_3 > 0.1) || (_local_3 < -0.1)))
            {
                _sp.width = _arg_1;
                _sp.height = _arg_1;
                _size = _arg_1;
            };
        }

        public function embed(_arg_1:Sprite, _arg_2:ColorScheme):*
        {
            _parent = _arg_1;
            _style = PointStyle(_arg_2);
        }

        public function get xProj():Number
        {
            return (_x);
        }

        public function get yProj():Number
        {
            return (_y);
        }

        public function get x():Number
        {
            return (_container.x);
        }


    }
}//package mb.symbols

