// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.expressions.Filter

package mb.expressions
{
    import mb.Notifier;
    import mb.DataSource;

    public class Filter extends Notifier 
    {

        public static const CHANGE:String = "change";

        protected var _data:DataSource;
        protected var _filters:Object;

        public function Filter(_arg_1:DataSource)
        {
            _data = _arg_1;
            _filters = {};
        }

        public function setStringMatch(_arg_1:String, _arg_2:String):*
        {
        }

        public function addStringMatch(_arg_1:String, _arg_2:String):*
        {
        }

        public function clearFilter(_arg_1:String):*
        {
            delete _filters[_arg_1];
        }

        public function filterRows(_arg_1:Array=null):Array
        {
            var _local_2:Array;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            if (!_arg_1)
            {
                _arg_1 = _data.getRecordIds();
            };
            _local_2 = [];
            _local_3 = _arg_1.length;
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_5 = _arg_1[_local_4];
                if (haveMatch(_local_5))
                {
                    _local_2.push(_local_5);
                };
                _local_4++;
            };
            return (_local_2);
        }

        public function setNumericRange(_arg_1:String, _arg_2:Number, _arg_3:Number):*
        {
        }

        public function addNumericMatch(_arg_1:String, _arg_2:Number):*
        {
        }

        public function setNumericMatch(_arg_1:String, _arg_2:Number):*
        {
        }

        public function haveMatch(_arg_1:int):Boolean
        {
            return (true);
        }


    }
}//package mb.expressions

