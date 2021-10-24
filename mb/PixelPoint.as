// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.PixelPoint

package mb
{
    import flash.display.DisplayObjectContainer;
    import flash.geom.Point;

    public class PixelPoint 
    {

        public var _x:Number = 0;
        public var _y:Number = 0;
        public var _mc:DisplayObjectContainer = null;

        public function PixelPoint(_arg_1:Number, _arg_2:Number, _arg_3:DisplayObjectContainer)
        {
            _x = _arg_1;
            _y = _arg_2;
            _mc = _arg_3;
        }

        public function print():*
        {
        }

        public function toLocal(_arg_1:DisplayObjectContainer):*
        {
            var _local_2:Point;
            _local_2 = new Point(_x, _y);
            _local_2 = Util.localToLocal(_local_2, _mc, _arg_1);
            _x = _local_2.x;
            _y = _local_2.y;
            _mc = _arg_1;
        }

        public function get x():Number
        {
            return (_x);
        }

        public function get y():Number
        {
            return (_y);
        }

        public function copyToLocal(_arg_1:DisplayObjectContainer):PixelPoint
        {
            var _local_2:Point;
            var _local_3:PixelPoint;
            _local_2 = new Point(_x, _y);
            _local_2 = Util.localToLocal(_local_2, _mc, _arg_1);
            return (new PixelPoint(_local_2.x, _local_2.y, _arg_1));
        }


    }
}//package mb

