// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.expressions.ExpressionFilter

package mb.expressions
{
    import mb.Notifier;
    import mb.DataSource;

    public class ExpressionFilter extends Notifier implements IFilter 
    {

        public static const CHANGE:String = "change";

        protected var _data:DataSource;
        private var _base:String;
        protected var _filters:Object;
        private var _compiled:Expression;

        public function ExpressionFilter(_arg_1:String, _arg_2:DataSource)
        {
            if (!_arg_1)
            {
                _arg_1 = "1 ";
            };
            _base = _arg_1;
            _data = _arg_2;
            _filters = {};
            compile();
        }

        private function addExp(_arg_1:String, _arg_2:String):*
        {
            if (!_filters[_arg_1])
            {
                _filters[_arg_1] = _arg_2;
            }
            else
            {
                _filters[_arg_1] = (_filters[_arg_1] + (_arg_2 + "&&"));
            };
            compile();
        }

        public function addNumericMatch(_arg_1:String, _arg_2:Number):*
        {
            var _local_3:String;
            _local_3 = ((_arg_1 + " ") + String(_arg_2));
            addExp(_arg_1, _local_3);
        }

        public function setNumericRange(_arg_1:String, _arg_2:Number, _arg_3:Number):*
        {
            var _local_4:String;
            _local_4 = (((((((_arg_1 + " ") + String(_arg_2)) + " >= ") + _arg_1) + " ") + String(_arg_3)) + "<= &&");
            addExp(_arg_1, _local_4);
        }

        public function addStringMatch(_arg_1:String, _arg_2:String):*
        {
            var _local_3:String;
            _local_3 = (((_arg_1 + " '") + _arg_2) + "'== ");
            addExp(_arg_1, _local_3);
        }

        public function setNumericMatch(_arg_1:String, _arg_2:Number):*
        {
            clearFilter(_arg_1);
            addNumericMatch(_arg_1, _arg_2);
        }

        public function setExpression(_arg_1:String):*
        {
            _base = _arg_1;
            compile();
        }

        public function clearFilter(_arg_1:String):*
        {
            delete _filters[_arg_1];
            compile();
        }

        public function set expression(_arg_1:String):*
        {
            setExpression(_arg_1);
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

        public function setStringMatch(_arg_1:String, _arg_2:String):*
        {
            clearFilter(_arg_1);
            addStringMatch(_arg_1, _arg_2);
        }

        private function compile():*
        {
            var _local_1:String;
            var _local_2:String;
            var _local_3:String;
            _local_1 = _base;
            for (_local_2 in _filters)
            {
                _local_3 = _filters[_local_2];
                if (_local_3)
                {
                    _local_1 = (_local_1 + (_local_3 + " && "));
                };
            };
            _compiled = new Expression(_local_1, _data);
            if (!_compiled.valid)
            {
            };
            notify(null, CHANGE);
        }

        public function haveMatch(_arg_1:int):Boolean
        {
            return (_compiled.procRow(_arg_1));
        }


    }
}//package mb.expressions

