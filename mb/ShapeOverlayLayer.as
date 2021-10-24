// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.ShapeOverlayLayer

package mb
{
    import mb.symbols.ShapeSymbol;
    import mb.symbols.IShapeSource;
    import mb.symbols.SymbolSet;
    import mb.symbols.ShapeSymbolMaker;
    import flash.geom.Point;

    public class ShapeOverlayLayer extends VectorLayer 
    {

        public static const ROLL_OVER:String = C.ROLL_OVER;//"roll_over"
        public static const ROLL_OUT:String = C.ROLL_OUT;//"roll_out"
        public static const CLICK:String = C.CLICK;//"click"

        protected var _activeShape:ShapeSymbol;
        protected var _shapes:IShapeSource;
        protected var _activeSet:SymbolSet;
        protected var _maker:ShapeSymbolMaker;
        protected var popupSuppressed:Boolean = false;
        protected var _style:ColorScheme;

        public function ShapeOverlayLayer(_arg_1:IShapeSource, _arg_2:DataSource)
        {
            super(_arg_2);
            _shapes = _arg_1;
            _layerType = OVERLAY;
            waitFor(_arg_1);
        }

        override protected function handleReadyState():*
        {
            _maker = new ShapeSymbolMaker(canvas_mc, _shapes);
            if (_style)
            {
                _maker.setStyle(_style);
            };
        }

        protected function inhibitMouse(_arg_1:Object=null):*
        {
            popupSuppressed = true;
            _map.mouse.unsetCallback(this, MouseService.MOUSE_MOVE);
        }

        protected function testMousePosition(_arg_1:Object=null):*
        {
            var _local_2:*;
            var _local_3:Point;
            var _local_4:SymbolSet;
            var _local_5:int;
            if (!this.visible)
            {
                return;
            };
            if (_map.mouse.buttonDown)
            {
            };
            _local_2 = getActiveId();
            if (_local_2 > -1)
            {
                if (canvas_mc.hitTestPoint(canvas_mc.stage.mouseX, canvas_mc.stage.mouseY, true))
                {
                    if (!_map.mouse.overMap)
                    {
                        clearActiveShape();
                        notify({"data":{"SHAPE_ID":_local_2}}, ROLL_OUT);
                    };
                    return;
                };
                clearActiveShape();
                notify({"data":{"SHAPE_ID":_local_2}}, ROLL_OUT);
            }
            else
            {
                if (!_map.mouse.overMap)
                {
                    return;
                };
            };
            _local_3 = _map.navigation.convScreenPointToProjectedPoint(new PixelPoint(canvas_mc.stage.mouseX, canvas_mc.stage.mouseY, canvas_mc.stage));
            _local_4 = _shapes.fetchIdsByPointTest(_local_3.x, _local_3.y);
            while (_local_4.hasNext())
            {
                _local_5 = _local_4.nextId();
                if (_local_5 != _local_2)
                {
                    _activeShape = ShapeSymbol(_maker.fetchSymbolById(_local_5));
                    refreshActiveShape();
                    if (canvas_mc.hitTestPoint(canvas_mc.stage.mouseX, canvas_mc.stage.mouseY, true))
                    {
                        notify({"data":{"SHAPE_ID":_local_5}}, ROLL_OVER);
                        return;
                    };
                };
            };
            clearActiveShape();
        }

        protected function handleMouseClick(_arg_1:Object):*
        {
            var _local_2:int;
            _local_2 = getActiveId();
            if (_local_2 > -1)
            {
                notify({"data":{"SHAPE_ID":_local_2}}, CLICK);
            };
        }

        public function clearActiveShape():*
        {
            canvas_mc.graphics.clear();
            _activeShape = null;
        }

        public function startMouseInteraction():*
        {
            if (!this.ready)
            {
                return;
            };
            _map.mouse.setCallback(this, testMousePosition, MouseService.MOUSE_MOVE);
        }

        public function getActiveId():int
        {
            return ((_activeShape) ? _activeShape.id : -1);
        }

        private function restoreMouse(_arg_1:Object=null):*
        {
            startMouseInteraction();
            testMousePosition();
            popupSuppressed = false;
        }

        public function setActiveId(_arg_1:int):*
        {
            if (_activeShape)
            {
                if (_activeShape.id == _arg_1)
                {
                    return;
                };
            };
            _activeShape = ShapeSymbol(_maker.fetchSymbolById(_arg_1));
            refreshActiveShape();
        }

        public function stopMouseInteraction():*
        {
            _map.mouse.unsetCallback(this, MouseService.MOUSE_MOVE);
            _map.mouse.unsetCallback(this, MouseService.CLICK);
        }

        override public function refresh():Boolean
        {
            refreshActiveShape();
            return (true);
        }

        override public function reposition():*
        {
        }

        public function setStyle(_arg_1:ColorScheme):*
        {
            if (_maker)
            {
                _maker.setStyle(_arg_1);
            };
            _style = _arg_1;
        }

        protected function refreshActiveShape():*
        {
            if (_activeShape)
            {
                canvas_mc.graphics.clear();
                _activeShape.updatePlacement(_map.navigation.getLayerXY());
            };
        }

        override public function destroy():*
        {
            stopMouseInteraction();
            super.destroy();
        }

        override public function rescale():*
        {
            refreshActiveShape();
        }


    }
}//package mb

