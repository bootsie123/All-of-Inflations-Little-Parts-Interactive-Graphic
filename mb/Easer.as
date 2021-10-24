// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.Easer

package mb
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    import flash.display.*;
    import flash.events.*;

    public class Easer extends Notifier 
    {

        public static const EASE:String = "ease";
        public static const ARRAY:String = "array";
        public static const NUMBER:String = "number";
        public static const OUT_REG:String = "out-slow";
        public static const OUT_STRONG:String = "out-fast";
        public static const LINEAR:String = "linear";
        public static const IN_REG:String = "in-slow";
        public static const IN_STRONG:String = "in-fast";
        public static const IN_OUT_REG:String = "in-out-slow";
        public static const IN_OUT_STRONG:String = "in-out-fast";
        public static const DEFAULT:String = OUT_STRONG;//"out-fast"

        private var startArray:Array;
        private var msStart:Number;
        private var msEnd:Number;
        private var currDuration:Number;
        private var ticker_mc:DisplayObject;
        private var myMethod:String;
        private var myMode:String;
        private var endArray:Object;

        private var startValue:Number = 0;
        private var endValue:Number = 0;
        private var defaultDuration:Number = 350;

        public function Easer(_arg_1:DisplayObjectContainer)
        {
            ticker_mc = Util.createSprite(_arg_1);
        }

        public function easeNumber(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:String=null):*
        {
            myMethod = ((_arg_4 == null) ? DEFAULT : _arg_4);
            myMode = NUMBER;
            msStart = new Date().getTime();
            msEnd = (msStart + _arg_3);
            startValue = _arg_1;
            endValue = _arg_2;
            currDuration = _arg_3;
            ticker_mc.addEventListener(Event.ENTER_FRAME, tickTock);
        }

        public function easeArray(_arg_1:Array, _arg_2:Array, _arg_3:Number, _arg_4:String=null):*
        {
            if (_arg_1.length != _arg_2.length)
            {
                return;
            };
            myMode = ARRAY;
            myMethod = ((_arg_4 == null) ? DEFAULT : _arg_4);
            msStart = new Date().getTime();
            msEnd = (msStart + _arg_3);
            startArray = _arg_1.slice();
            endArray = _arg_2.slice();
            currDuration = _arg_3;
            ticker_mc.addEventListener(Event.ENTER_FRAME, tickTock);
        }

        public function calcInterpolatedValue(_arg_1:Number, _arg_2:Number, _arg_3:Number):Number
        {
            var _local_4:Number;
            var _local_5:Number;
            _local_4 = (_arg_3 - _arg_2);
            if (((myMethod == OUT_STRONG) || (myMethod == OUT_REG)))
            {
                _local_5 = ((_local_4 * (Math.pow((_arg_1 - 1), 3) + 1)) + _arg_2);
            }
            else
            {
                if (((myMethod == IN_STRONG) || (myMethod == IN_REG)))
                {
                    _local_5 = ((_local_4 * Math.pow(_arg_1, 3)) + _arg_2);
                }
                else
                {
                    _local_5 = (_arg_2 + (_arg_1 * (_arg_3 - _arg_2)));
                };
            };
            return (_local_5);
        }

        public function tickTock(_arg_1:Object):*
        {
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:Object;
            var _local_5:Number;
            var _local_6:Array;
            var _local_7:int;
            var _local_8:Number;
            var _local_9:Number;
            _local_2 = new Date().getTime();
            _local_3 = ((_local_2 - msStart) / (msEnd - msStart));
            _local_4 = {};
            if (myMode == ARRAY)
            {
                _local_6 = [];
                _local_7 = 0;
                while (_local_7 < startArray.length)
                {
                    _local_8 = startArray[_local_7];
                    _local_9 = endArray[_local_7];
                    _local_5 = calcInterpolatedValue(_local_3, _local_8, _local_9);
                    _local_6.push(_local_5);
                    _local_7++;
                };
                _local_4.value = _local_6;
            }
            else
            {
                _local_5 = calcInterpolatedValue(_local_3, startValue, endValue);
                _local_4.value = _local_5;
            };
            if (_local_2 >= (msEnd - 20))
            {
                _local_4.done = true;
                _local_4.value = ((myMode == ARRAY) ? endArray : endValue);
                this.stopEaser();
            }
            else
            {
                _local_4.done = false;
            };
            notify(_local_4, EASE);
        }

        public function stopEaser():*
        {
            ticker_mc.removeEventListener(Event.ENTER_FRAME, tickTock);
        }


    }
}//package mb

