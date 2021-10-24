// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.LabelField

package mb
{
    import flash.filters.DropShadowFilter;
    import flash.display.DisplayObjectContainer;

    public class LabelField extends SuperTextField 
    {

        private const _defaultPlacement:String = "n";
        private var dropShadow:DropShadowFilter;

        private var _placement:String = _defaultPlacement;//"n"
        private var _halo:Boolean = false;

        public function LabelField(_arg_1:DisplayObjectContainer=null, _arg_2:String="")
        {
            super(_arg_1, _arg_2);
        }

        public function remove():*
        {
            txt.parent.removeChild(txt);
            txt = null;
        }

        public function set halo(_arg_1:Boolean):*
        {
            if (((!(_halo)) && (_arg_1)))
            {
                _halo = true;
                dropShadow = new DropShadowFilter(0, 0, 0xFFFFFF, 0.8, 2, 2, 4, 1);
                addFilter(dropShadow);
                txt.autoSize = "left";
            }
            else
            {
                if (((_halo) && (_arg_1)))
                {
                    txt.filters = filters_arr;
                }
                else
                {
                    if (((_halo) && (!(_arg_1))))
                    {
                        _halo = false;
                        filters_arr = null;
                        txt.filters = null;
                    };
                };
            };
        }

        override public function set y(_arg_1:Number):*
        {
            var _local_2:Number;
            _local_2 = 0;
            switch (_placement)
            {
                case C.CENTER:
                case C.E:
                case C.W:
                    _local_2 = (-(Math.round((txt.height / 2))) - 1);
                    break;
                case C.N:
                case C.NW:
                case C.NE:
                    _local_2 = (-(Math.round(txt.height)) - 1);
                    break;
                case C.SE:
                case C.SW:
                case C.S:
                    _local_2 = 1;
                    break;
            };
            txt.y = (_arg_1 + _local_2);
        }

        public function init(_arg_1:LabelField):*
        {
            var _local_2:Array;
            var _local_3:String;
            applyTemplate(_arg_1);
            this.placement = _arg_1.placement;
            this.halo = _arg_1.halo;
            this.x = _x;
            this.y = _y;
            _local_2 = _arg_1.filters;
            if (_local_2)
            {
                for (_local_3 in _local_2)
                {
                    this.addFilter(_local_2[_local_3]);
                };
            };
        }

        public function get halo():Boolean
        {
            return (_halo);
        }

        public function set placement(_arg_1:String):*
        {
            if (!_arg_1)
            {
                _placement = _defaultPlacement;
            }
            else
            {
                _placement = _arg_1.toLowerCase();
            };
            x = _x;
            y = _y;
        }

        override protected function alignText():*
        {
        }

        public function get placement():String
        {
            return (_placement);
        }

        override public function set x(_arg_1:Number):*
        {
            var _local_2:Number;
            _local_2 = 0;
            switch (_placement)
            {
                case C.CENTER:
                case C.N:
                case C.S:
                    _local_2 = -(Math.round((txt.width / 2)));
                    break;
                case C.NW:
                case C.SW:
                    _local_2 = (-(Math.round(txt.width)) + 2);
                    break;
                case C.NE:
                case C.SE:
                    _local_2 = -2;
                    break;
                case C.E:
                    _local_2 = 4;
                    break;
                case C.W:
                    _local_2 = (-(Math.round(txt.width)) - 4);
                    break;
            };
            txt.x = (_arg_1 + _local_2);
        }


    }
}//package mb

