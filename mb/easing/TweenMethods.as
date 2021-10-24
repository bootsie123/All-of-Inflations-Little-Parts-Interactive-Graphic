// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.easing.TweenMethods

package mb.easing
{
    public class TweenMethods 
    {


        public static function easeInSine(_arg_1:Number):Number
        {
            return (1 - Math.sin((((1 - _arg_1) * Math.PI) / 2)));
        }

        public static function easeInWeakOutStrong(_arg_1:Number):*
        {
            return (easeOutCubic(easeInOutSine(_arg_1)));
        }

        public static function easeOutSineStrong(_arg_1:Number):Number
        {
            return (easeOutSine(easeOutSine(_arg_1)));
        }

        public static function linear(_arg_1:Number):Number
        {
            return (_arg_1);
        }

        public static function easeInOutSineStrong(_arg_1:Number):Number
        {
            return (easeInOutSine(easeInOutSine(_arg_1)));
        }

        public static function easeOutQuadratic(_arg_1:Number):Number
        {
            return (1 - Math.pow((1 - _arg_1), 2));
        }

        public static function easeOutCubic(_arg_1:Number):Number
        {
            return (1 - Math.pow((1 - _arg_1), 3));
        }

        public static function easeOutHybrid(_arg_1:Number):Number
        {
            return (easeOutQuadratic(easeOutSine(_arg_1)));
        }

        public static function easeOutSine(_arg_1:Number):Number
        {
            return (Math.sin(((_arg_1 * Math.PI) / 2)));
        }

        public static function easeInOutSineExtraStrong(_arg_1:Number):Number
        {
            return (easeInOutSine(easeInOutSineStrong(_arg_1)));
        }

        public static function easeInOutSine(_arg_1:Number):Number
        {
            return (0.5 - (Math.cos((_arg_1 * Math.PI)) / 2));
        }


    }
}//package mb.easing

