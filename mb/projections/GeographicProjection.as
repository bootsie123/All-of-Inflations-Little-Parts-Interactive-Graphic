// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.projections.GeographicProjection

package mb.projections
{
    import flash.geom.Point;

    public class GeographicProjection extends Projection 
    {

        public static const GEOGRAPHIC:String = "Geodetic";

        public function GeographicProjection()
        {
            _name = GEOGRAPHIC;
            useEllipsoid = false;
        }

        override protected function unprojectEll(_arg_1:Number, _arg_2:Number):Point
        {
            return (new Point(_arg_2, _arg_1));
        }

        override protected function unprojectSph(_arg_1:Number, _arg_2:Number):Point
        {
            return (new Point(_arg_2, _arg_1));
        }

        override protected function projectEll(_arg_1:Number, _arg_2:Number):Point
        {
            return (new Point(_arg_2, _arg_1));
        }

        override protected function projectSph(_arg_1:Number, _arg_2:Number):Point
        {
            return (new Point(_arg_2, _arg_1));
        }


    }
}//package mb.projections

