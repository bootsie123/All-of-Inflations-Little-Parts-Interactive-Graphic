// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.MapExtent

package mb
{
    import mb.placement.Alignment;
    import flash.geom.Point;
    import flash.display.MovieClip;
    import flash.geom.Rectangle;

    public class MapExtent extends Waiter 
    {

        private var _align:Alignment;
        private var _limitBounds:Boolean = true;
        private var _top:Number;
        private var _right:Number;
        private var _lockShape:Boolean = false;
        private var _bottom:Number;
        private var _left:Number;

        public function MapExtent(_arg_1:Alignment)
        {
            _align = _arg_1;
            waitFor(_arg_1);
            startWaiting();
        }

        public function getCenterPoint():Point
        {
            return (convScreenFocusToProjectedPoint(0.5, 0.5));
        }

        public function recenterAndRescale(_arg_1:Number, _arg_2:Number, _arg_3:Number):*
        {
            recenter(_arg_1, _arg_2);
            rescale(_arg_3);
            adjustPosition();
        }

        public function setScreenFocus(_arg_1:Number, _arg_2:Number):*
        {
            var _local_3:Point;
            var _local_4:Point;
            var _local_5:Number;
            var _local_6:Number;
            _local_3 = getCenterPoint();
            _local_4 = convScreenFocusToProjectedPoint(_arg_1, _arg_2);
            _local_5 = (_local_4.x - _local_3.x);
            _local_6 = (_local_4.y - _local_3.y);
            _left = (_left + _local_5);
            _right = (_right + _local_5);
            _top = (_top + _local_6);
            _bottom = (_bottom + _local_6);
        }

        public function convScreenPointToScreenFocus(_arg_1:PixelPoint):Point
        {
            var _local_2:MovieClip;
            var _local_3:PixelPoint;
            var _local_4:Number;
            var _local_5:Number;
            _local_2 = _align.mc;
            _local_3 = _arg_1.copyToLocal(_local_2.parent);
            _local_4 = ((_local_3.x - _local_2.x) / _local_2.width);
            _local_5 = ((_local_3.y - _local_2.y) / _local_2.height);
            return (new Point(_local_4, _local_5));
        }

        public function get metersPerPixel():Number
        {
            return (_align.metersPerPixel / getRelativeScale());
        }

        public function getScaledBoundingBox():ScaledBoundingBox
        {
            var _local_1:ScaledBoundingBox;
            return (new ScaledBoundingBox(getRelativeScale(), metersPerPixel, _left, _top, _right, _bottom));
        }

        public function get right():Number
        {
            return (_right);
        }

        public function get left():Number
        {
            return (_left);
        }

        public function set limitBounds(_arg_1:Boolean):*
        {
            _limitBounds = _arg_1;
        }

        public function getScreenFocus():Point
        {
            var _local_1:Point;
            var _local_2:Number;
            var _local_3:Number;
            _local_1 = getCenterPoint();
            _local_2 = ((_local_1.x - _align.projLeft) / _align.projWidth);
            _local_3 = ((_align.projTop - _local_1.y) / _align.projHeight);
            return (new Point(_local_2, _local_3));
        }

        public function get height():Number
        {
            return (_top - _bottom);
        }

        public function getRelativeScale():Number
        {
            var _local_1:Number;
            var _local_2:Number;
            var _local_3:Number;
            _local_1 = (_align.projWidth / width);
            _local_2 = (_align.projHeight / height);
            return ((_local_1 < _local_2) ? _local_1 : _local_2);
        }

        public function get bottom():Number
        {
            return (_bottom);
        }

        public function get pixelsPerMeter():Number
        {
            var _local_1:Number;
            _local_1 = _align.pixelsPerMeter;
            return (_local_1 * getRelativeScale());
        }

        public function recenterByPixelShift(_arg_1:Number, _arg_2:Number):*
        {
            var _local_3:Point;
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:Number;
            _local_3 = getCenterPoint();
            _local_4 = metersPerPixel;
            _local_5 = (_local_3.x = (_local_3.x - (_arg_1 * _local_4)));
            _local_6 = (_local_3.y = (_local_3.y + (_arg_2 * _local_4)));
            recenter(_local_5, _local_6);
            adjustPosition();
        }

        public function setBounds(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):*
        {
            _left = _arg_1;
            _top = _arg_2;
            _right = _arg_3;
            _bottom = _arg_4;
        }

        public function setBoundingBox(_arg_1:Rectangle):*
        {
            _left = _arg_1.x;
            _bottom = _arg_1.y;
            _top = (_bottom + _arg_1.height);
            _right = (_left + _arg_1.width);
        }

        public function get width():Number
        {
            return (_right - _left);
        }

        public function recenter(_arg_1:Number, _arg_2:Number):*
        {
            var _local_3:Number;
            var _local_4:Number;
            _local_3 = width;
            _local_4 = height;
            _left = (_arg_1 - (_local_3 / 2));
            _bottom = (_arg_2 - (_local_4 / 2));
            _top = (_bottom + _local_4);
            _right = (_left + _local_3);
        }

        public function get box():Rectangle
        {
            return (new Rectangle(_left, _bottom, width, height));
        }

        public function reset():*
        {
            _left = _align.projLeft;
            _top = _align.projTop;
            _right = _align.projRight;
            _bottom = _align.projBottom;
        }

        public function adjustShape():*
        {
            if (!_lockShape)
            {
                return;
            };
        }

        public function get top():Number
        {
            return (_top);
        }

        public function adjustPosition():*
        {
            var _local_1:Number;
            var _local_2:Number;
            if (!_limitBounds)
            {
                return;
            };
            _local_1 = 0;
            _local_2 = 0;
            if (_left < _align.projLeft)
            {
                _local_1 = (_align.projLeft - _left);
            }
            else
            {
                if (_right > _align.projRight)
                {
                    _local_1 = (_align.projRight - _right);
                };
            };
            if (_top > _align.projTop)
            {
                _local_2 = (_align.projTop - _top);
            }
            else
            {
                if (_bottom < _align.projBottom)
                {
                    _local_2 = (_align.projBottom - _bottom);
                };
            };
            _top = (_top + _local_2);
            _bottom = (_bottom + _local_2);
            _left = (_left + _local_1);
            _right = (_right + _local_1);
        }

        public function clone():MapExtent
        {
            var _local_1:MapExtent;
            _local_1 = new MapExtent(_align);
            _local_1.setBounds(_left, _top, _right, _bottom);
            return (_local_1);
        }

        public function convScreenFocusToProjectedPoint(_arg_1:Number, _arg_2:Number):Point
        {
            _arg_2 = (_top - (_arg_2 * height));
            _arg_1 = (_left + (_arg_1 * width));
            return (new Point(_arg_1, _arg_2));
        }

        public function getMapContainerOffset():Point
        {
            var _local_1:Number;
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:Number;
            _local_1 = (_align.projLeft - _left);
            _local_2 = (_top - _align.projTop);
            _local_3 = (_local_1 * pixelsPerMeter);
            _local_4 = (_local_2 * pixelsPerMeter);
            _local_3 = Math.round(_local_3);
            _local_4 = Math.round(_local_4);
            return (new Point(_local_3, _local_4));
        }

        override protected function handleReadyState():*
        {
            reset();
        }

        public function rescale(_arg_1:*):*
        {
            var _local_2:Point;
            var _local_3:Number;
            var _local_4:Number;
            if (_arg_1 == getRelativeScale())
            {
                return;
            };
            _local_2 = getCenterPoint();
            _local_3 = (_align.projWidth / _arg_1);
            _local_4 = (_align.projHeight / _arg_1);
            _left = (_local_2.x - (_local_3 / 2));
            _bottom = (_local_2.y - (_local_4 / 2));
            _right = (left + _local_3);
            _top = (_bottom + _local_4);
        }


    }
}//package mb

