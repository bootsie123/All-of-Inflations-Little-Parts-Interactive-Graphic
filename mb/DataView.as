// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.DataView

package mb
{
    import mb.expressions.ExpressionFilter;
    import mb.expressions.Filter;
    import mb.expressions.IExpression;

    public class DataView extends Waiter 
    {

        protected var _data:DataSource;
        protected var _filter:ExpressionFilter;
        protected var sumFieldName:String;
        protected var dateFieldName:String;
        protected var minDate:Date;
        protected var aggFieldName:String;
        protected var lastMinDate:Date;
        protected var aggRecords_obj:Object;
        protected var yAggFieldName:String;
        protected var lastMaxDate:Date;
        protected var xAggFieldName:String;
        protected var spatialAggRecords_obj:Object;
        protected var maxDate:Date;
        protected var storedRecordIds_arr:Array;

        protected var _haveAggregation:Boolean = false;
        protected var _haveSummation:Boolean = false;
        protected var _haveSpatialAggregation:Boolean = false;
        protected var haveStoredRecordIds:Boolean = false;
        protected var lastMinIdx:Number = 0;
        protected var lastMaxIdx:Number = 0;
        protected var haveDateRange:Boolean = false;

        public function DataView(_arg_1:DataSource)
        {
            _data = _arg_1;
            _filter = new ExpressionFilter("", _arg_1);
            _filter.setCallback(this, handleFilterChange, Filter.CHANGE);
            if (_arg_1)
            {
                addDependency(_arg_1);
            };
            init();
        }

        public function setTextualDateRange(_arg_1:String, _arg_2:String, _arg_3:String):*
        {
            setDateRange(_arg_1, Util.strToDate(_arg_2), Util.strToDate(_arg_3));
        }

        public function getRecordCount():Number
        {
            var _local_1:Array;
            var _local_2:Number;
            _local_1 = getRecordIds();
            _local_2 = _local_1.length;
            if (isNaN(_local_2))
            {
                return (0);
            };
            return (_local_2);
        }

        protected function init():*
        {
            monitorDependencies();
        }

        public function get filter():ExpressionFilter
        {
            return (_filter);
        }

        public function handleFilterChange(_arg_1:Object):*
        {
            haveStoredRecordIds = false;
        }

        public function setAggregation(_arg_1:String, _arg_2:String=null):*
        {
            _haveAggregation = true;
            aggFieldName = _arg_1;
            if (_arg_2 != null)
            {
                _haveSummation = true;
                sumFieldName = _arg_2;
            };
        }

        public function get data():DataSource
        {
            return (_data);
        }

        public function clearAggregation():*
        {
            _haveAggregation = false;
        }

        public function get haveAggregation():Boolean
        {
            return (_haveAggregation);
        }

        public function fetchMatchingRecords(_arg_1:IExpression):ResultSet
        {
            var _local_2:ResultSet;
            var _local_3:Array;
            var _local_4:int;
            var _local_5:Array;
            var _local_6:int;
            var _local_7:int;
            var _local_8:Number;
            _local_2 = new ResultSet(_data);
            if (!_arg_1.valid)
            {
                return (_local_2);
            };
            _local_3 = getRecordIds();
            _local_4 = _local_3.length;
            _local_5 = [];
            _local_6 = 0;
            while (_local_6 < _local_4)
            {
                _local_7 = _local_3[_local_6];
                _local_8 = Number(_arg_1.procRow(_local_7));
                if (_local_8)
                {
                    _local_5.push(_local_7);
                };
                _local_6++;
            };
            _local_2.setIds(_local_5);
            return (_local_2);
        }

        public function setDateRange(_arg_1:String, _arg_2:Date, _arg_3:Date):*
        {
            dateFieldName = _arg_1;
            minDate = _arg_2;
            maxDate = _arg_3;
            haveDateRange = true;
        }

        public function getRecordIds():Array
        {
            var _local_1:Array;
            var _local_2:Array;
            _local_1 = _data.getRecordIds();
            if (haveStoredRecordIds)
            {
                _local_2 = storedRecordIds_arr;
            }
            else
            {
                _local_2 = _filter.filterRows(_local_1);
                storedRecordIds_arr = _local_2;
                haveStoredRecordIds = true;
            };
            if (haveDateRange)
            {
                _local_2 = filterRecordsByDate(storedRecordIds_arr);
            };
            return (_local_2);
        }

        public function filterRecordsByDate(_arg_1:Array):Array
        {
            var _local_2:Array;
            var _local_3:Array;
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:Date;
            var _local_9:Number;
            var _local_10:Number;
            if ((((!(minDate)) || (!(maxDate))) || (!(dateFieldName))))
            {
                return (_arg_1);
            };
            _local_2 = [];
            if (!_data.fieldExists(dateFieldName))
            {
                return ([]);
            };
            _local_3 = _data.getFieldArray(dateFieldName);
            _local_4 = minDate.getTime();
            _local_5 = maxDate.getTime();
            _local_6 = _arg_1.length;
            _local_9 = 0;
            while (_local_9 < _local_6)
            {
                _local_7 = _arg_1[_local_9];
                _local_8 = _local_3[_local_7];
                _local_10 = _local_8.getTime();
                if (_local_10 >= _local_4)
                {
                    if (_local_10 <= _local_5)
                    {
                        _local_2.push(_local_7);
                    };
                };
                _local_9++;
            };
            return (_local_2);
        }


    }
}//package mb

