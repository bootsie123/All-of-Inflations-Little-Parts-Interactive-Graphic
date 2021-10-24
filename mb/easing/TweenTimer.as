// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.easing.TweenTimer

package mb.easing
{
    import flash.utils.Timer;
    import flash.events.Event;

    public class TweenTimer 
    {

        private var _start:Number;
        private var _timer:Timer;
        private var _duration:int;
        private var _tween:ITween;

        private var _frames:int = 0;
        private var _delay:int = 0;

        public function TweenTimer(_arg_1:Number)
        {
            var _local_2:int;
            super();
            _local_2 = int(Math.round((1000 / _arg_1)));
            _timer = new Timer(_local_2);
            _timer.addEventListener("timer", tickTock);
        }

        public function tickTock(_arg_1:Event):*
        {
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:Number;
            _local_2 = new Date().getTime();
            _local_3 = ((_local_2 - _start) - _delay);
            if (_local_3 < 0)
            {
                return;
            };
            _frames++;
            _local_4 = (_local_3 / _duration);
            if (_local_4 >= 0.998)
            {
                reset();
                _local_4 = 1;
            };
            _tween.procTween(_local_4);
        }

        public function start(_arg_1:int, _arg_2:ITween, _arg_3:int=0):*
        {
            reset();
            _tween = _arg_2;
            _duration = _arg_1;
            _delay = _arg_3;
            _start = new Date().getTime();
            _timer.start();
        }

        public function reset():*
        {
            _frames = 0;
            _timer.stop();
        }


    }
}//package mb.easing

