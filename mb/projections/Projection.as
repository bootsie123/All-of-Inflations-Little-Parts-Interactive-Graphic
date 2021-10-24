// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.projections.Projection

package mb.projections
{
    import flash.geom.Point;

    public class Projection implements IGeoProjection 
    {

        public static const GRS80:String = "grs80";
        public static const WGS72:String = "wgs72";
        public static const CLARKE1866:String = "clarke1866";
        protected static const _R:Number = 6378137;
        protected static const _deg2rad:Number = (Math.PI / 180);//0.0174532925199433
        protected static const _rad2deg:Number = (180 / Math.PI);//57.2957795130823
        protected static var _xy:Point = new Point();
        protected static var _ll:Point = new Point();

        protected var _long0:Number;
        protected var _lat0:Number;
        protected var _lat1:Number;
        protected var _lat2:Number;
        protected var _dist0:Number;
        protected var _a:*;
        protected var _e:*;
        protected var _f:*;
        protected var _name:String;

        protected var _useEllipsoid:Boolean = false;
        protected var _ellipsoid:* = GRS80;//"grs80"
        protected var _k0:Number = 1;
        protected var _x0:Number = 0;
        protected var _y0:Number = 0;

        public function Projection()
        {
            _name = GeographicProjection.GEOGRAPHIC;
        }

        public function reprojectFast(_arg_1:Number, _arg_2:Number, _arg_3:Projection):Point
        {
            var _local_4:Point;
            var _local_5:Point;
            _local_4 = _arg_3.unprojectFast(_arg_1, _arg_2);
            _local_5 = projectFast(_local_4.y, _local_4.x);
            return (_local_5);
        }

        public function reproject(_arg_1:Number, _arg_2:Number, _arg_3:Projection):Point
        {
            var _local_4:Point;
            _local_4 = reprojectFast(_arg_1, _arg_2, _arg_3);
            return (_local_4.clone());
        }

        public function setFalseEastingNorthing(_arg_1:Number, _arg_2:Number):*
        {
            _x0 = _arg_1;
            _y0 = _arg_2;
        }

        public function get name():String
        {
            return (_name);
        }

        public function projectFast(_arg_1:Number, _arg_2:Number):Point
        {
            if (_useEllipsoid)
            {
                return (projectEll(_arg_1, _arg_2));
            };
            return (projectSph(_arg_1, _arg_2));
        }

        public function project(_arg_1:Number, _arg_2:Number):Point
        {
            return (projectFast(_arg_1, _arg_2).clone());
        }

        protected function init():*
        {
        }

        protected function unprojectEll(_arg_1:Number, _arg_2:Number):Point
        {
            var _local_3:Point;
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:Point;
            var _local_7:Number;
            var _local_8:Number;
            _local_3 = unprojectSph(_arg_1, _arg_2);
            _local_4 = _local_3.y;
            _local_5 = _local_3.x;
            _local_6 = projectEll(_local_4, _local_5);
            _local_7 = _local_6.x;
            _local_8 = _local_6.y;
            return (unprojectSph(((2 * _arg_1) - _local_7), ((2 * _arg_2) - _local_8)));
        }

        protected function unprojectSph(_arg_1:Number, _arg_2:Number):Point
        {
            return (new Point(_arg_2, _arg_1));
        }

        public function scaleFactor(_arg_1:Number, _arg_2:Number):Number
        {
            return (1);
        }

        public function setEllipsoid(_arg_1:String):*
        {
            if (_arg_1 == GRS80)
            {
                _a = 6378137;
                _f = (1 / 298.257);
            }
            else
            {
                if (_arg_1 == WGS72)
                {
                    _a = 6378135;
                    _f = (1 / 298.26);
                }
                else
                {
                    if (_arg_1 == CLARKE1866)
                    {
                        _a = 6378206.4;
                        _f = (1 / 294.98);
                    }
                    else
                    {
                        return;
                    };
                };
            };
            _e = Math.sqrt(((2 * _f) - (_f * _f)));
            _ellipsoid = _arg_1;
        }

        protected function projectEll(_arg_1:Number, _arg_2:Number):Point
        {
            return (new Point(_arg_2, _arg_1));
        }

        protected function projectSph(_arg_1:Number, _arg_2:Number):Point
        {
            return (new Point(_arg_2, _arg_1));
        }

        public function unprojectFast(_arg_1:Number, _arg_2:Number):Point
        {
            if (_useEllipsoid)
            {
                return (unprojectEll(_arg_1, _arg_2));
            };
            return (unprojectSph(_arg_1, _arg_2));
        }

        public function unproject(_arg_1:Number, _arg_2:Number):Point
        {
            return (unprojectFast(_arg_1, _arg_2).clone());
        }

        public function compare(_arg_1:IGeoProjection):Boolean
        {
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:Point;
            var _local_5:Point;
            if (this.name != _arg_1.name)
            {
                return (false);
            };
            if (this == _arg_1)
            {
                return (true);
            };
            _local_2 = 50;
            _local_3 = 50;
            _local_4 = this.project(_local_2, _local_3);
            _local_5 = _arg_1.project(_local_2, _local_3);
            if (((_local_4.x == _local_5.x) && (_local_4.y == _local_5.y)))
            {
                return (true);
            };
            return (false);
        }

        public function setScaleFactor(_arg_1:Number):*
        {
            _k0 = _arg_1;
        }

        public function set useEllipsoid(_arg_1:Boolean):*
        {
            if (((_arg_1) && (_ellipsoid)))
            {
                setEllipsoid(_ellipsoid);
                _useEllipsoid = true;
            }
            else
            {
                _useEllipsoid = false;
            };
            init();
        }


    }
}//package mb.projections

