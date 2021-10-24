// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.NavigationManager

package mb
{
    import flash.display.Sprite;
    import mb.placement.Alignment;
    import mb.zooming.ScaleSet;
    import mb.projections.Projection;
    import mb.easing.TweenTimer;
    import mb.zooming.RelativeScales;
    import flash.geom.Point;
    import mb.easing.MapExtentTween;
    import mb.easing.TweenMethods;

    public class NavigationManager extends Waiter 
    {

        public static const ZOOM_EASE:String = "zoomstep";
        public static const PAN:String = "pan";
        public static const ZOOM:String = "zoom";
        public static const NAVIGATE:String = "navigate";
        public static const RESCALE:String = "rescale";

        private var _container:Sprite;
        private var _align:Alignment;
        private var _scales:ScaleSet;
        private var _proj:Projection;
        private var _easer:TweenTimer;
        private var _extent:MapExtent;

        private var _limitPanning:Boolean = true;
        private var _easeTime:Number = 400;

        public function NavigationManager(_arg_1:Sprite, _arg_2:Alignment, _arg_3:Projection)
        {
            _container = _arg_1;
            _align = _arg_2;
            _proj = _arg_3;
            _easer = new TweenTimer(_arg_1.stage.frameRate);
            _scales = new RelativeScales([1]);
            waitFor(_arg_2);
            startWaiting();
        }

        public function zoomToLevel(_arg_1:int, _arg_2:Number=NaN, _arg_3:Number=NaN, _arg_4:Boolean=true):*
        {
            var _local_5:Number;
            _local_5 = _scales.convLevelToScale(_arg_1);
            zoomToScreenFocus(_arg_2, _arg_3, _local_5);
        }

        public function setPanShift(_arg_1:Number, _arg_2:Number):*
        {
            var _local_3:Point;
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:Number;
            _extent.recenterByPixelShift(_arg_1, _arg_2);
            _local_3 = _extent.getMapContainerOffset();
            _local_4 = _local_3.x;
            _local_5 = _local_3.y;
            _local_6 = _container.x;
            _local_7 = _container.y;
            if (((_local_4 == _local_6) && (_local_5 == _local_7)))
            {
                return;
            };
            _container.x = _local_4;
            _container.y = _local_5;
            notify(null, PAN);
            notify(null, NAVIGATE);
        }

        public function getVisibleBounds():ScaledBoundingBox
        {
            return (_extent.getScaledBoundingBox());
        }

        public function get metersPerPixel():Number
        {
            return (_extent.metersPerPixel);
        }

        private function handleZoomTween(_arg_1:MapExtent, _arg_2:Boolean):*
        {
            zoomToExtent(_arg_1);
        }

        public function zoomToEastingNorthing(_arg_1:Number, _arg_2:Number, _arg_3:Number=NaN):*
        {
            var _local_4:Point;
            var _local_5:Number;
            var _local_6:Number;
            _extent.recenterAndRescale(_arg_1, _arg_2, _arg_3);
            _local_4 = _extent.getMapContainerOffset();
            _local_5 = Math.round(_local_4.x);
            _local_6 = Math.round(_local_4.y);
            _container.x = _local_5;
            _container.y = _local_6;
            notify(null, RESCALE);
            notify(null, NAVIGATE);
        }

        public function getExtent():MapExtent
        {
            return (_extent.clone());
        }

        private function handleZoomEasing(_arg_1:Object):*
        {
        }

        public function getRelativeScale():Number
        {
            return (_extent.getRelativeScale());
        }

        public function set limitPanning(_arg_1:Boolean):*
        {
            _limitPanning = _arg_1;
        }

        public function zoomToLatLong(_arg_1:Number, _arg_2:Number, _arg_3:Number=NaN):*
        {
            var _local_4:Point;
            _local_4 = _proj.project(_arg_1, _arg_2);
            zoomToEastingNorthing(_local_4.x, _local_4.y, _arg_3);
        }

        public function get scaleFactor():Number
        {
            var _local_1:Point;
            var _local_2:Point;
            var _local_3:Number;
            _local_1 = _extent.getCenterPoint();
            _local_2 = _proj.unproject(_local_1.x, _local_1.y);
            return (_proj.scaleFactor(_local_2.y, _local_2.x));
        }

        public function getZoomLevel():int
        {
            var _local_1:int;
            return (_scales.convScaleToLevel(scale));
        }

        public function zoomToScreenFocus(_arg_1:Number, _arg_2:Number, _arg_3:Number=NaN):*
        {
            var _local_4:Point;
            var _local_5:MapExtent;
            var _local_6:Point;
            var _local_7:Number;
            if (isNaN(_arg_1))
            {
                _arg_1 = 0.5;
            };
            if (isNaN(_arg_2))
            {
                _arg_2 = 0.5;
            };
            _local_4 = _extent.convScreenFocusToProjectedPoint(_arg_1, _arg_2);
            _local_5 = getExtent();
            _local_5.recenterAndRescale(_local_4.x, _local_4.y, _arg_3);
            _local_4 = _local_5.getCenterPoint();
            _local_6 = _extent.convScreenFocusToProjectedPoint(0.5, 0.5);
            _local_7 = getRelativeScale();
            _easer.start(_easeTime, new MapExtentTween(TweenMethods.easeOutCubic, handleZoomTween, getExtent(), _local_5));
        }

        public function get scale():Number
        {
            return (_extent.getRelativeScale());
        }

        public function set scales(_arg_1:Array):*
        {
            _scales = new RelativeScales(_arg_1);
        }

        public function zoomIn():*
        {
            var _local_1:int;
            _local_1 = _scales.convScaleToLevel(scale);
            zoomToLevel((_local_1 + 1));
        }

        public function easeToEastingNorthing(_arg_1:Number, _arg_2:Number, _arg_3:Number=NaN):*
        {
        }

        public function getLayerXY():XY
        {
            var _local_1:Number;
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:XY;
            _local_1 = _extent.pixelsPerMeter;
            _local_2 = -(_extent.pixelsPerMeter);
            _local_3 = (-(_local_1) * _align.projLeft);
            _local_4 = (-(_local_2) * _align.projTop);
            _local_5 = new XY(_local_1, _local_2, _local_3, _local_4);
            return (_local_5);
        }

        public function convScreenPointToProjectedPoint(_arg_1:PixelPoint):Point
        {
            var _local_2:Point;
            var _local_3:Point;
            _local_2 = _extent.convScreenPointToScreenFocus(_arg_1);
            return (_extent.convScreenFocusToProjectedPoint(_local_2.x, _local_2.y));
        }

        public function zoomToFullExtent():*
        {
            zoomToScreenFocus(0.5, 0.5, 1);
        }

        public function convScreenPointToLatLong(_arg_1:PixelPoint):Point
        {
            var _local_2:Point;
            var _local_3:Point;
            _local_2 = convScreenPointToProjectedPoint(_arg_1);
            return (_proj.unproject(_local_2.x, _local_2.y));
        }

        override protected function handleReadyState():*
        {
            _extent = new MapExtent(_align);
        }

        public function zoomOut():*
        {
            var _local_1:int;
            _local_1 = _scales.convScaleToLevel(scale);
            zoomToLevel((_local_1 - 1));
        }

        public function zoomToScreenPoint(_arg_1:PixelPoint, _arg_2:Number):*
        {
        }

        public function zoomToExtent(_arg_1:MapExtent):*
        {
            var _local_2:Point;
            var _local_3:Number;
            _local_2 = _arg_1.getCenterPoint();
            _local_3 = _arg_1.getRelativeScale();
            zoomToEastingNorthing(_local_2.x, _local_2.y, _local_3);
        }


    }
}//package mb

