// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.MapLayer

package mb
{
    import flash.display.Sprite;

    public class MapLayer extends Waiter 
    {

        public static const UNDEFINED:String = "undef";
        public static const VECTOR:String = "vector";
        public static const RASTER:String = "raster";
        public static const IMAGE:String = "image";
        public static const TILE:String = "tile";
        public static const TILE_STACK:String = "tile_stack";
        public static const INDEX_LAYER:String = "index";
        public static const POLYGON:String = "polygon";
        public static const POLYLINE:String = "polyline";
        public static const SCREEN:String = "screen";
        public static const POINT:String = "point";
        public static const LABEL:String = "label";
        public static const VECTOR_POINT:String = "vector_point";
        public static const OVERLAY:String = "overlay";

        protected var container_mc:Sprite;
        protected var _map:MapInfo;
        protected var overlay_mc:Sprite;

        protected var _layerType:String = UNDEFINED;//"undef"
        protected var _layerFamily:String = UNDEFINED;//"undef"
        protected var _minScale:Number = 0;
        protected var _maxScale:Number = 10000;
        protected var _hidden:Boolean = false;

        public function MapLayer()
        {
            container_mc = new Sprite();
        }

        public function place(_arg_1:MapInfo, _arg_2:Sprite):*
        {
            _map = _arg_1;
            _arg_2.addChild(container_mc);
            if (!_arg_1.navigation.ready)
            {
                waitFor(_arg_1.navigation);
            };
            startWaiting();
        }

        public function get container():Sprite
        {
            return (container_mc);
        }

        public function set maxScale(_arg_1:Number):*
        {
            _maxScale = _arg_1;
        }

        public function set minScale(_arg_1:Number):*
        {
            _minScale = _arg_1;
        }

        public function get hidden():Boolean
        {
            return (_hidden);
        }

        public function get type():String
        {
            return (_layerType);
        }

        public function set alpha(_arg_1:Number):*
        {
            container_mc.alpha = _arg_1;
        }

        public function hide():*
        {
            _hidden = true;
            container_mc.visible = false;
        }

        public function testScale(_arg_1:Number):Boolean
        {
            if (((_arg_1 >= _minScale) && (_arg_1 <= _maxScale)))
            {
                return (true);
            };
            return (false);
        }

        public function reposition():*
        {
        }

        public function get alpha():Number
        {
            return (container_mc.alpha);
        }

        public function get family():*
        {
            return (_layerFamily);
        }

        public function set mask(_arg_1:VectorLayer):*
        {
            container_mc.mask = _arg_1.container;
        }

        public function get visible():Boolean
        {
            return ((container_mc.visible) && (testScale(_map.navigation.scale)));
        }

        public function destroy():*
        {
            if (container_mc != null)
            {
                container_mc.parent.removeChild(container_mc);
                container_mc = null;
            };
        }

        public function show():*
        {
            _hidden = false;
            if (container_mc.visible == false)
            {
                container_mc.visible = true;
            };
        }

        public function rescale():*
        {
        }


    }
}//package mb

