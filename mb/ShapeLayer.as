// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.ShapeLayer

package mb
{
    import mb.symbols.IShapeSource;
    import mb.symbols.ShapeSymbol;
    import flash.display.Sprite;
    import mb.symbols.SymbolSet;
    import mb.symbols.ShapeSymbolManager;
    import flash.display.*;
    import mb.symbols.*;

    public class ShapeLayer extends VectorLayer 
    {

        public static const ROLL_OVER:String = C.ROLL_OVER;//"roll_over"
        public static const ROLL_OUT:String = C.ROLL_OUT;//"roll_out"
        public static const CLICK:String = C.CLICK;//"click"
        protected static var _hitStyle:ColorScheme;

        protected var _shapes:IShapeSource;
        protected var _hoverLayer:ShapeOverlayLayer;
        protected var _hitTestLayer:ShapeOverlayLayer;
        protected var _hoverStyle:ColorScheme;
        protected var _selectionStyle:ColorScheme;
        protected var _style:ColorScheme;
        protected var _selectedShape:ShapeSymbol;
        protected var testLayer_mc:Sprite;

        protected var activeShapeId:Number = -1;
        protected var popupSuppressed:Boolean = false;
        protected var _mouseRequested:Boolean = false;

        public function ShapeLayer(_arg_1:IShapeSource, _arg_2:DataSource=null)
        {
            super(_arg_2);
            _style = new ColorScheme(_arg_2);
            _shapes = _arg_1;
            waitFor(_arg_1);
            if (!_hitStyle)
            {
                _hitStyle = new ColorScheme();
                _hitStyle.setFill(0, 0);
            };
            setCallback(this, handleReady, Notifier.READY);
        }

        override public function show():*
        {
            super.show();
            refresh();
        }

        public function updateLayer():*
        {
            var _local_1:SymbolSet;
            _local_1 = _symbolManager.fetchNewSymbols();
            drawShapes(_local_1);
        }

        public function get hover():ColorScheme
        {
            if (!_hoverStyle)
            {
                _hoverStyle = new ColorScheme();
                _hoverStyle.setFill(0xCCCCCC, 0.2);
                _selectionStyle = _hoverStyle;
            };
            return (_hoverStyle);
        }

        public function clear():*
        {
            _symbolManager.clearSymbols();
            if (overlay_mc)
            {
                overlay_mc.graphics.clear();
            };
        }

        protected function handleReady(_arg_1:Object):*
        {
            if (visible)
            {
                refresh();
            };
        }

        override public function reposition():*
        {
            updateLayer();
        }

        protected function drawShapes(_arg_1:SymbolSet):*
        {
            var _local_2:XY;
            var _local_3:ShapeSymbol;
            _local_2 = _map.navigation.getLayerXY();
            while (_arg_1.hasNext())
            {
                _local_3 = ShapeSymbol(_arg_1.nextSymbol());
                _local_3.updatePlacement(_local_2);
            };
        }

        public function setStyle(_arg_1:ColorScheme):*
        {
            if (_symbolManager)
            {
                _symbolManager.setStyle(_arg_1);
            };
            _style = _arg_1;
        }

        public function get style():ColorScheme
        {
            return (_style);
        }

        public function get bounds():BoundingBox
        {
            return (_shapes.bounds);
        }

        protected function handleMouseOut(_arg_1:Object):*
        {
            _hoverLayer.clearActiveShape();
            notify({"data":_arg_1.data}, ROLL_OUT);
        }

        override public function setCallback(_arg_1:Object, _arg_2:Function, _arg_3:String):*
        {
            super.setCallback(_arg_1, _arg_2, _arg_3);
            if (_arg_3 == ROLL_OVER)
            {
                setCallback(this, initMouseActions, Notifier.READY);
            };
        }

        private function initMouseActions(_arg_1:Object):*
        {
            var _local_2:ColorScheme;
            if (_hitTestLayer)
            {
                return;
            };
            _hoverLayer = new ShapeOverlayLayer(_shapes, _data);
            _hoverLayer.setStyle(this.hover);
            _map.layers.addLayer(_hoverLayer);
            _hitTestLayer = new ShapeOverlayLayer(_shapes, _data);
            _local_2 = new ColorScheme();
            _local_2.setFill(0xFF0000, 0);
            _local_2.setStroke(2, 0xFF, 0);
            _hitTestLayer.setStyle(_local_2);
            _map.layers.addLayer(_hitTestLayer);
            _hitTestLayer.setCallback(this, handleMouseOver, ROLL_OVER);
            _hitTestLayer.setCallback(this, handleMouseOut, ROLL_OUT);
            _hitTestLayer.startMouseInteraction();
        }

        protected function handleMouseOver(_arg_1:Object):*
        {
            var _local_2:Object;
            var _local_3:int;
            var _local_4:Record;
            _local_2 = _arg_1.data;
            _local_3 = _local_2.SHAPE_ID;
            _hoverLayer.setActiveId(_local_3);
            _local_4 = new Record(_data, _local_3);
            _local_2.rec = _local_4;
            notify({"data":_local_2}, ROLL_OVER);
        }

        public function setHoverStyle(_arg_1:ColorScheme):*
        {
            _hoverStyle = _arg_1;
            if (_hoverLayer)
            {
                _hoverLayer.setStyle(_arg_1);
            };
        }

        override public function refresh():Boolean
        {
            if (!this.ready)
            {
                return (false);
            };
            if (!this.visible)
            {
                return (false);
            };
            if (!_rendered)
            {
                _symbolManager = new ShapeSymbolManager(_shapes, _map.navigation, canvas_mc);
                _symbolManager.setStyle(_style);
                if (_filter)
                {
                    _symbolManager.setFilter(_filter);
                };
                _rendered = true;
            };
            T.start();
            clear();
            updateLayer();
            T.stop("*********  ShapeLayer.refresh()");
            return (true);
        }

        public function get shapes():IShapeSource
        {
            return (_shapes);
        }

        override protected function handleReadyState():*
        {
            testLayer_mc = Util.createSprite(container_mc);
        }

        override public function rescale():*
        {
            refresh();
        }

        override public function destroy():*
        {
            super.destroy();
            if (_hitTestLayer)
            {
                _hitTestLayer.destroy();
                _hitTestLayer = null;
            };
            if (_hoverLayer)
            {
                _hoverLayer.destroy();
                _hoverLayer = null;
            };
            if (!_shapes.ready)
            {
                _shapes.unsetCallback(this, Notifier.READY);
            };
            _shapes = null;
        }


    }
}//package mb

