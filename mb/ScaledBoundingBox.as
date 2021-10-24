// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.ScaledBoundingBox

package mb
{
    public class ScaledBoundingBox extends BoundingBox 
    {

        protected var _scale:Number;
        protected var _mpp:Number;

        public function ScaledBoundingBox(_arg_1:Number, _arg_2:Number, _arg_3:Number=NaN, _arg_4:Number=NaN, _arg_5:Number=NaN, _arg_6:Number=NaN)
        {
            super(_arg_3, _arg_4, _arg_5, _arg_6);
            _mpp = _arg_2;
            _scale = _arg_1;
        }

        public function get metersPerPixel():Number
        {
            return (_mpp);
        }

        public function get pixelsPerMeter():Number
        {
            return (1 / _mpp);
        }

        public function addPixelPadding(_arg_1:Number, _arg_2:Number):*
        {
            var _local_3:Number;
            var _local_4:Number;
            _local_3 = (_arg_1 * _mpp);
            _local_4 = (_arg_2 * _mpp);
            _left = (_left - _local_3);
            _right = (_right + _local_3);
            _top = (_top + _local_4);
            _bottom = (_bottom - _local_4);
        }


    }
}//package mb

