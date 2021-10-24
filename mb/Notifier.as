// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.Notifier

package mb
{
    public class Notifier implements INotifier 
    {

        public static const READY:String = "ready_once";
        public static const COMPLETE:String = "complt_once";
        private static var singlesObj:Object = {
            "READY":true,
            "COMPLETE":true
        };

        private var _ready:Boolean = false;
        private var callbacksObj:Object;

        public function Notifier()
        {
            callbacksObj = {};
        }

        public function get ready():Boolean
        {
            return (_ready);
        }

        public function setCallback(_arg_1:Object, _arg_2:Function, _arg_3:String):*
        {
            var _local_4:UFunction;
            _local_4 = new UFunction(_arg_1, _arg_2);
            if ((((_arg_3 == READY) || (_arg_3 == COMPLETE)) && (this.ready)))
            {
                _local_4.exec({});
            }
            else
            {
                if (!callbacksObj[_arg_3])
                {
                    callbacksObj[_arg_3] = [];
                };
                callbacksObj[_arg_3].push(_local_4);
            };
        }

        public function notify(_arg_1:Object, _arg_2:String):*
        {
            var _local_3:Array;
            var _local_4:String;
            var _local_5:UFunction;
            if (!callbacksObj[_arg_2])
            {
                return;
            };
            if (_arg_1 == null)
            {
                _arg_1 = {};
            };
            _arg_1["ref"] = this;
            _local_3 = callbacksObj[_arg_2];
            for (_local_4 in _local_3)
            {
                if (_arg_2 != READY)
                {
                    if (_arg_2 == COMPLETE)
                    {
                    };
                };
                _local_5 = _local_3[_local_4];
                _local_5.exec(_arg_1);
            };
            if (singlesObj[_arg_2])
            {
                delete callbacksObj[_arg_2];
            };
        }

        public function haveCallback(_arg_1:String):Boolean
        {
            return ((callbacksObj[_arg_1]) ? true : false);
        }

        public function unsetCallback(_arg_1:Object, _arg_2:String):Boolean
        {
            var _local_3:Array;
            var _local_4:Array;
            var _local_5:Boolean;
            var _local_6:String;
            var _local_7:UFunction;
            if (!callbacksObj[_arg_2])
            {
                return (false);
            };
            _local_3 = callbacksObj[_arg_2];
            _local_4 = [];
            _local_5 = false;
            for (_local_6 in _local_3)
            {
                _local_7 = _local_3[_local_6];
                if (_local_7.caller == _arg_1)
                {
                    _local_5 = true;
                }
                else
                {
                    _local_4.push(_local_7);
                };
            };
            if (_local_5)
            {
                callbacksObj[_arg_2] = _local_4;
                return (true);
            };
            return (false);
        }

        protected function notifyReady(_arg_1:Object=null):*
        {
            if (!_ready)
            {
                _ready = true;
                notify(null, COMPLETE);
                notify(null, READY);
            };
        }


    }
}//package mb

