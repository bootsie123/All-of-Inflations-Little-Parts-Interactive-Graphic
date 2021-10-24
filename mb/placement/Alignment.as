// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.placement.Alignment

package mb.placement
{
    import mb.Waiter;
    import flash.display.MovieClip;
    import mb.projections.Projection;
    import mb.C;
    import flash.geom.Rectangle;
    import mb.ProjectedPoint;

    public class Alignment extends Waiter 
    {

        protected var align_mc:MovieClip;
        protected var _projBottom:Number;
        protected var _projRightOrig:Number;
        protected var _alignLeft:Number;
        protected var _alignRight:Number;
        protected var _proj:Projection;
        protected var _projRight:Number;
        protected var _projLeftOrig:Number;
        protected var _alignBottom:Number;
        protected var _projLeft:Number;
        protected var _projBottomOrig:Number;
        protected var _projTopOrig:Number;
        protected var _alignTop:Number;
        protected var _projTop:Number;

        protected var _alignStr:String = C.TOP;//"top"
        protected var _marginLeft:Number = 0;
        protected var _marginTop:Number = 0;
        protected var _marginBottom:Number = 0;
        protected var _marginRight:Number = 0;

        public function Alignment(_arg_1:MovieClip, _arg_2:Projection)
        {
            var _local_3:Rectangle;
            super();
            _proj = _arg_2;
            align_mc = _arg_1;
            _local_3 = _arg_1.getBounds(_arg_1.parent);
            _alignLeft = _local_3.left;
            _alignTop = _local_3.top;
            _alignRight = _local_3.right;
            _alignBottom = _local_3.bottom;
        }

        public function get projLeft():Number
        {
            return (_projLeft);
        }

        public function get projBottom():Number
        {
            return (_projBottom);
        }

        public function get alignHeight():Number
        {
            return (_alignBottom - _alignTop);
        }

        public function get metersPerPixel():Number
        {
            var _local_1:Number;
            return (((_projRight - _projLeft) / align_mc.width) / 1);
        }

        public function get projCenterPoint():ProjectedPoint
        {
            return (new ProjectedPoint(((_projLeft + _projRight) / 2), ((_projTop + _projBottom) / 2)));
        }

        public function get alignRight():Number
        {
            return (_alignRight);
        }

        protected function init():*
        {
            var _local_1:Number;
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:Number;
            var _local_11:Number;
            var _local_12:Number;
            var _local_13:Number;
            var _local_14:Number;
            var _local_15:Number;
            var _local_16:Number;
            var _local_17:Number;
            var _local_18:Number;
            _local_1 = _projLeftOrig;
            _local_2 = _projTopOrig;
            _local_3 = _projRightOrig;
            _local_4 = _projBottomOrig;
            _local_5 = (_alignLeft + _marginLeft);
            _local_6 = (_alignTop + _marginTop);
            _local_7 = (_alignRight - _marginRight);
            _local_8 = (_alignBottom - _marginBottom);
            _local_9 = Math.abs((_local_6 - _local_8));
            _local_10 = Math.abs((_local_5 - _local_7));
            _local_11 = Math.abs((_local_2 - _local_4));
            _local_12 = Math.abs((_local_1 - _local_3));
            _local_13 = Math.abs((_local_10 / _local_9));
            _local_14 = Math.abs((_local_12 / _local_11));
            _local_15 = 0;
            _local_16 = 0;
            if (_local_13 < _local_14)
            {
                _local_17 = (_local_12 / _local_10);
                _local_16 = ((_local_17 * _local_9) - _local_11);
            }
            else
            {
                _local_17 = (_local_11 / _local_9);
                _local_15 = ((_local_17 * _local_10) - _local_12);
            };
            if (_local_15 > 0)
            {
                if ((((_alignStr == C.W) || (_alignStr == C.NW)) || (_alignStr == C.SW)))
                {
                    _local_3 = (_local_3 + _local_15);
                }
                else
                {
                    if ((((_alignStr == C.E) || (_alignStr == C.NE)) || (_alignStr == C.SE)))
                    {
                        _local_1 = (_local_1 - _local_15);
                    }
                    else
                    {
                        _local_1 = (_local_1 - (_local_15 / 2));
                        _local_3 = (_local_3 + (_local_15 / 2));
                    };
                };
            };
            if (_local_16 > 0)
            {
                if ((((_alignStr == C.E) || (_alignStr == C.W)) || (_alignStr == C.CENTER)))
                {
                    _local_2 = (_local_2 + (_local_16 / 2));
                    _local_4 = (_local_4 - (_local_16 / 2));
                }
                else
                {
                    if ((((_alignStr == C.S) || (_alignStr == C.SE)) || (_alignStr == C.SW)))
                    {
                        _local_2 = (_local_2 + _local_16);
                    }
                    else
                    {
                        _local_4 = (_local_4 - _local_16);
                    };
                };
            };
            _local_18 = Math.abs(((_local_3 - _local_1) / _local_10));
            if (_marginLeft > 0)
            {
                _local_1 = (_local_1 - (_marginLeft * _local_18));
            };
            if (_marginTop > 0)
            {
                _local_2 = (_local_2 + (_marginTop * _local_18));
            };
            if (_marginRight > 0)
            {
                _local_3 = (_local_3 + (_marginRight * _local_18));
            };
            if (_marginBottom > 0)
            {
                _local_4 = (_local_4 - (_marginBottom * _local_18));
            };
            _projLeft = _local_1;
            _projTop = _local_2;
            _projRight = _local_3;
            _projBottom = _local_4;
            monitorDependencies();
        }

        public function get alignLeft():Number
        {
            return (_alignLeft);
        }

        public function get mc():MovieClip
        {
            return (align_mc);
        }

        public function get projTop():Number
        {
            return (_projTop);
        }

        public function get pixelsPerMeter():Number
        {
            return ((_alignLeft - _alignRight) / (_projLeft - _projRight));
        }

        public function get alignTop():Number
        {
            return (_alignTop);
        }

        public function get projRight():Number
        {
            return (_projRight);
        }

        public function get alignWidth():Number
        {
            return (_alignRight - _alignLeft);
        }

        public function get box():Rectangle
        {
            return (new Rectangle(_projLeft, _projBottom, projWidth, projHeight));
        }

        public function get alignBottom():Number
        {
            return (_alignBottom);
        }

        public function get projHeight():Number
        {
            return (_projTop - _projBottom);
        }

        public function get projWidth():Number
        {
            return (_projRight - _projLeft);
        }

        public function get projTopLeftPoint():ProjectedPoint
        {
            return (new ProjectedPoint(_projLeft, _projTop));
        }


    }
}//package mb.placement

