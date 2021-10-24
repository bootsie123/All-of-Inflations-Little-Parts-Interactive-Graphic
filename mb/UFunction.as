// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.UFunction

package mb
{
    public class UFunction 
    {

        private var _instance:Object;
        private var _action:Function;

        public function UFunction(_arg_1:Object, _arg_2:Function)
        {
            _instance = _arg_1;
            _action = _arg_2;
        }

        public function exec(_arg_1:Object=null):*
        {
            var _local_2:Array;
            _local_2 = ((_arg_1) ? [_arg_1] : []);
            _action.apply(_instance, _local_2);
        }

        public function get caller():Object
        {
            return (_instance);
        }


    }
}//package mb

