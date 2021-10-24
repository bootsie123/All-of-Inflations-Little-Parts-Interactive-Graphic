// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.MapStack

package mb
{
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import mb.projections.Projection;
    import mb.placement.Alignment;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import flash.display.DisplayObject;
    import flash.display.*;
    import mb.projections.*;
    import mb.placement.*;
    import mb.zooming.*;

    public class MapStack extends Waiter 
    {

        public static const DRAG:String = "drag";
        public static const CLICK:String = "click";
        public static const DBL_CLICK:String = "dblclick";
        public static const MOUSE_DRAG:String = "drag";
        public static const MOUSE_MOVE:String = "move";

        private var _neatlineScheme:ColorScheme;
        private var align_mc:MovieClip;
        private var _screen:Sprite;
        private var _mouse:MouseService;
        private var _neatlineCanvas:Sprite;
        private var _navigation:NavigationManager;
        private var _proj:Projection;
        private var _layers:LayerManager;
        private var _alignment:Alignment;
        private var _mapContainer:Sprite;
        private var _stackContainer:Sprite;

        private var _useClickZoom:Boolean = false;
        private var _useDragPan:Boolean = false;
        private var _useClickRecenter:Boolean = false;

        public function MapStack(_arg_1:MovieClip, _arg_2:Projection, _arg_3:Alignment)
        {
            this.align_mc = _arg_1;
            _arg_1.visible = false;
            _alignment = _arg_3;
            _proj = _arg_2;
            _stackContainer = Util.createSprite(_arg_1.parent);
            _stackContainer.mouseEnabled = false;
            _stackContainer.mouseChildren = false;
            _stackContainer.scrollRect = new Rectangle(0, 0, _arg_1.width, _arg_1.height);
            _mapContainer = Util.createSprite(_stackContainer);
            _screen = Util.createSprite(_stackContainer.parent);
            Util.drawMatchingRectangle(_screen, _arg_1);
            _mouse = new MouseService(_screen);
            _mouse.setCallback(this, handleScreenClick, MouseService.CLICK);
            _mouse.setCallback(this, handleScreenDrag, MouseService.MOUSE_DRAG);
            _mouse.setCallback(this, handleMouseMove, MouseService.MOUSE_MOVE);
            _navigation = new NavigationManager(_mapContainer, _alignment, _proj);
            _navigation.setCallback(this, handleRescale, NavigationManager.RESCALE);
            _navigation.setCallback(this, handlePan, NavigationManager.PAN);
            waitFor(_navigation);
            _layers = new LayerManager(_mapContainer, new MapInfo(this));
        }

        public function hideNeatline():*
        {
            _stackContainer.graphics.clear();
        }

        public function get container():Sprite
        {
            return (_stackContainer);
        }

        public function get navigation():NavigationManager
        {
            return (_navigation);
        }

        public function set useDragPan(_arg_1:Boolean):*
        {
            _useDragPan = _arg_1;
        }

        public function set panning(_arg_1:Boolean):*
        {
            _useDragPan = _arg_1;
        }

        public function hide():*
        {
            _stackContainer.visible = false;
        }

        public function setNeatline(_arg_1:ColorScheme):*
        {
            _neatlineScheme = _arg_1;
            showNeatline();
        }

        public function get mouse():MouseService
        {
            return (_mouse);
        }

        public function get height():Number
        {
            return (_alignment.alignHeight);
        }

        public function handleRescale(_arg_1:Object):*
        {
            _layers.setLayerVisibility();
            _layers.repositionLayers();
        }

        public function addLayer(_arg_1:MapLayer):*
        {
            waitFor(_arg_1);
            _layers.addLayer(_arg_1);
        }

        public function get hidden():Boolean
        {
            return (!(_stackContainer.visible));
        }

        private function handleScreenClick(_arg_1:Object):*
        {
            var _local_2:PixelPoint;
            var _local_3:Point;
            var _local_4:Point;
            var _local_5:int;
            if (_useClickZoom)
            {
                _local_2 = mouse.pos;
                _local_3 = navigation.getExtent().convScreenPointToScreenFocus(_local_2);
                _local_4 = navigation.getExtent().convScreenFocusToProjectedPoint(_local_3.x, _local_3.y);
                _local_5 = navigation.getZoomLevel();
                navigation.zoomToLevel((_local_5 + 1), _local_3.x, _local_3.y);
            };
        }

        public function showNeatline():*
        {
            if (_neatlineScheme)
            {
                Util.drawMatchingRectangle(_screen, align_mc, _neatlineScheme);
            };
        }

        private function handleScreenDrag(_arg_1:Object):*
        {
            var _local_2:Point;
            if (_useDragPan)
            {
                _local_2 = Point(_arg_1.data);
                _navigation.setPanShift(_local_2.x, _local_2.y);
            };
        }

        public function get width():Number
        {
            return (_alignment.alignWidth);
        }

        public function set useClickRecenter(_arg_1:Boolean):*
        {
            _useClickRecenter = _arg_1;
        }

        public function handlePan(_arg_1:Object):*
        {
            _layers.reframeLayers();
        }

        public function get projection():Projection
        {
            return (_proj);
        }

        private function handleAlignmentReady(_arg_1:Object):*
        {
        }

        public function set mask(_arg_1:DisplayObject):*
        {
            _stackContainer.scrollRect = null;
            _stackContainer.mask = _arg_1;
        }

        private function handleMouseMove(_arg_1:Object):*
        {
            var _local_2:PixelPoint;
            var _local_3:Point;
            _local_2 = PixelPoint(_arg_1.data);
            _local_3 = _navigation.convScreenPointToLatLong(_local_2);
            if (!mouse.overScreen)
            {
                _local_3 = null;
            };
            notify({"data":_local_3}, MOUSE_MOVE);
        }

        public function set zooming(_arg_1:Boolean):*
        {
            _useClickZoom = _arg_1;
        }

        public function get alignment():Alignment
        {
            return (_alignment);
        }

        public function get screen():Sprite
        {
            return (_screen);
        }

        public function load():*
        {
            _alignment.setCallback(this, handleAlignmentReady, Notifier.READY);
            startWaiting();
        }

        public function set useClickZoom(_arg_1:Boolean):*
        {
            _useClickZoom = _arg_1;
        }

        public function get layers():LayerManager
        {
            return (_layers);
        }

        public function show():*
        {
            _stackContainer.visible = true;
        }


    }
}//package mb

