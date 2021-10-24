// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.PointLayer

package mb
{
    import mb.symbols.PointSource;
    import mb.symbols.PointSymbolManager;

    public class PointLayer extends VectorLayer 
    {

        public static const ROLL_OVER:String = C.ROLL_OVER;//"roll_over"
        public static const ROLL_OUT:String = C.ROLL_OUT;//"roll_out"
        public static const CLICK:String = C.CLICK;//"click"

        protected var _symbols:PointSource;
        private var overlaySymbol:SimpleSymbol;
        protected var _hoverStyle:PointStyle;
        protected var _style:PointStyle;

        protected var rollOverColor:Number = 16764006;
        protected var rollOverAlpha:Number = 1;
        protected var defaultPointSize:Number = 10;
        protected var _hitId:int = -1;

        public function PointLayer(_arg_1:PointSource)
        {
            super(_arg_1.data);
            _symbols = _arg_1;
            _layerType = POINT;
        }

        override protected function handleReadyState():*
        {
            if (this.ready)
            {
                return;
            };
            _symbolManager = new PointSymbolManager(_symbols, _map.navigation, container_mc);
            _symbolManager.setStyle(_style);
            if (_filter)
            {
                _symbolManager.setFilter(_filter);
            };
            if (visible)
            {
                refresh();
            };
        }

        public function get style():PointStyle
        {
            if (!_style)
            {
                _style = new PointStyle(_data);
            };
            return (_style);
        }

        public function get hover():PointStyle
        {
            if (!_hoverStyle)
            {
                _hoverStyle = new PointStyle(_data);
            };
            return (_hoverStyle);
        }

        private function handleClick(_arg_1:Object):*
        {
            var _local_2:Record;
            if (_hitId > -1)
            {
                _local_2 = new Record(_data, _hitId);
                notify({"rec":_local_2}, CLICK);
            };
        }

        private function handleMouseMove(_arg_1:Object=null):*
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:Record;
            if (((this.hidden) || (_map.hidden)))
            {
                return;
            };
            _local_2 = _symbolManager.fetchMouseoverId();
            _local_3 = -1;
            _local_4 = -1;
            if (_hitId == -1)
            {
                if (_local_2 != -1)
                {
                    _local_4 = _local_2;
                };
            }
            else
            {
                if (_local_2 != _hitId)
                {
                    _local_4 = _local_2;
                    _local_3 = _hitId;
                };
            };
            if (_local_3 != -1)
            {
                notify({"rec":new Record(_data, _local_3)}, ROLL_OUT);
                _hitId = -1;
            };
            if (_local_4 != -1)
            {
                _hitId = _local_4;
                _local_5 = new Record(_data, _local_4);
                notify({"rec":_local_5}, ROLL_OVER);
            };
        }

        public function setHoverStyle(_arg_1:PointStyle):*
        {
            _hoverStyle = _arg_1;
        }

        override public function refresh():Boolean
        {
            if (_rendered)
            {
                _symbolManager.updateSymbolStyle(true);
            }
            else
            {
                _symbolManager.updateSymbolPlacement();
                _rendered = true;
            };
            return (true);
        }

        override public function reposition():*
        {
            _symbolManager.updateSymbolPlacement();
        }

        public function setStyle(_arg_1:PointStyle):*
        {
            if (_symbolManager)
            {
                _symbolManager.setStyle(_arg_1);
            };
            _style = _arg_1;
        }

        override public function show():*
        {
            super.show();
            rescale();
        }

        override public function rescale():*
        {
            var _local_1:Boolean;
            _local_1 = _style.haveSizeTransform;
            _symbolManager.updateSymbolPlacement(_local_1);
        }


    }
}//package mb

