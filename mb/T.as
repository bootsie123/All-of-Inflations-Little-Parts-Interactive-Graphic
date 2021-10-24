// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.T

package mb
{
    public class T 
    {

        private static var stackArr:Array;


        public static function stop(_arg_1:String=""):*
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:String;
            _local_2 = stackArr.pop();
            _local_3 = new Date().getTime();
            _local_4 = (((_arg_1 + " ") + (_local_3 - _local_2)) + "ms");
            if (stackArr.length > 0)
            {
                _local_4 = (_local_4 + ((" (nested " + stackArr.length) + " deep)."));
            };
        }

        public static function start():*
        {
            if (!stackArr)
            {
                stackArr = [];
            };
            stackArr.push(new Date().getTime());
        }


    }
}//package mb

