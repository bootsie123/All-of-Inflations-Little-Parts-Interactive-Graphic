// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.easing.NumberTween

package mb.easing
{
    public class NumberTween implements ITween 
    {

        private var _method:Function;
        private var _a:Number;
        private var _b:Number;
        private var _done:Boolean = false;
        private var _callback:Function;

        public function NumberTween(_arg_1:Function, _arg_2:Function, _arg_3:Number, _arg_4:Number)
        {
            _a = _arg_3;
            _b = _arg_4;
            _method = _arg_1;
            _callback = _arg_2;
        }

        public function procTween(_arg_1:Number):*
        {
            var _local_2:Number;
            if (_done)
            {
                return;
            };
            _arg_1 = _method(_arg_1);
            if (_arg_1 >= 1)
            {
                _done = true;
            };
            _local_2 = ((_b * _arg_1) + (_a * (1 - _arg_1)));
            _callback(_local_2, _done);
        }


    }
}//package mb.easing

