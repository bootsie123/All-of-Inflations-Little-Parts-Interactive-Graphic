// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.DataSource

package mb
{
    import mb.importing.TabDataLoader;
    import mb.expressions.IFilter;
    import mb.expressions.Expression;
    import mb.expressions.IExpression;
    import mb.expressions.*;
    import mb.importing.*;

    public class DataSource extends Waiter 
    {

        public static const STRING:String = "string";
        public static const INTEGER:String = "int";
        public static const DOUBLE:String = "double";
        public static const DATE:String = "date";

        private var schemaObj:Object = null;
        private var tabDataLoader:TabDataLoader;
        private var indexesObj:Object;
        protected var numRecords:int = 0;
        protected var dataObj:Object;

        public function DataSource()
        {
            dataObj = {};
            schemaObj = {};
            indexesObj = {};
        }

        public function traceRecord(_arg_1:int):*
        {
            var _local_2:Object;
            var _local_3:String;
            _local_2 = getAssocRecord(_arg_1);
            for (_local_3 in _local_2)
            {
            };
        }

        public function getRecordByKey(_arg_1:String, _arg_2:Object):Record
        {
            var _local_3:int;
            _local_3 = getIdByKey(_arg_1, _arg_2);
            if (_local_3 == -1)
            {
                return (null);
            };
            return (new Record(this, _local_3));
        }

        public function getValueByKey(_arg_1:String, _arg_2:Object, _arg_3:String):Object
        {
            var _local_4:int;
            if (!fieldExists(_arg_3))
            {
                return (null);
            };
            _local_4 = getIdByKey(_arg_1, _arg_2);
            if (_local_4 != -1)
            {
                return (dataObj[_arg_3]);
            };
            return (null);
        }

        public function getAssocRecord(_arg_1:Number):Object
        {
            var _local_2:Object;
            var _local_3:String;
            _local_2 = {};
            for (_local_3 in dataObj)
            {
                _local_2[_local_3] = dataObj[_local_3][_arg_1];
            };
            return (_local_2);
        }

        public function loadTabData(_arg_1:String, _arg_2:Boolean=false):*
        {
            tabDataLoader = new TabDataLoader(_arg_1, schemaObj, _arg_2);
            this.addDependency(tabDataLoader);
            this.monitorDependencies();
            tabDataLoader.load();
        }

        public function getRecordSet(_arg_1:IFilter=null):RecordSet
        {
            var _local_2:RecordSet;
            _local_2 = new RecordSet(this, getRecordIds());
            if (_arg_1)
            {
                _local_2.applyFilter(_arg_1);
            };
            return (_local_2);
        }

        public function initEmpty(_arg_1:int):*
        {
            numRecords = _arg_1;
            monitorDependencies();
        }

        public function getFieldType(_arg_1:String):String
        {
            if (!fieldExists(_arg_1))
            {
                return (STRING);
            };
            return (schemaObj[_arg_1]);
        }

        public function getString(_arg_1:Number, _arg_2:String):String
        {
            var _local_3:Object;
            if (!fieldExists(_arg_2))
            {
                return ("");
            };
            _local_3 = dataObj[_arg_2][_arg_1];
            if (_local_3 == null)
            {
                return ("");
            };
            return (String(_local_3));
        }

        public function getAttributeValue(_arg_1:Number, _arg_2:String):Object
        {
            if (!fieldExists(_arg_2))
            {
                return (null);
            };
            return (dataObj[_arg_2][_arg_1]);
        }

        public function fetchUniqueValues(_arg_1:String, _arg_2:String=null):Object
        {
            var _local_3:Object;
            var _local_4:Boolean;
            var _local_5:Expression;
            var _local_6:Array;
            var _local_7:int;
            var _local_8:Object;
            if (!fieldExists(_arg_1))
            {
                return ({});
            };
            _local_3 = {};
            _local_4 = false;
            if (_arg_2)
            {
                _local_5 = new Expression(_arg_2, this);
                _local_4 = true;
            };
            _local_6 = dataObj[_arg_1];
            _local_7 = 0;
            while (_local_7 < numRecords)
            {
                if( (!_local_4) || (_local_5.procRow(_local_7)) )
                {
                    _local_8 = _local_6[_local_7];
                    if (!_local_3[_local_8])
                    {
                        _local_3[_local_8] = 1;
                    }
                    else
                    {
                        _local_3[_local_8]++;
                    };
                };
                _local_7++;
            };
            return (_local_3);
        }

        public function traceField(_arg_1:String, _arg_2:String=null):*
        {
            var _local_3:Boolean;
            var _local_4:Boolean;
            var _local_5:int;
            var _local_6:Object;
            var _local_7:Object;
            _local_3 = fieldExists(_arg_1);
            _local_4 = fieldExists(_arg_2);
            if (_local_3)
            {
                _local_5 = 0;
                while (_local_5 < numRecords)
                {
                    _local_6 = getAttributeValue(_local_5, _arg_1);
                    _local_7 = ((_local_4) ? getAttributeValue(_local_5, _arg_2) : "");
                    _local_5++;
                };
            };
        }

        public function setField(_arg_1:String, _arg_2:String):*
        {
            schemaObj[_arg_1] = _arg_2;
        }

        public function getMatchingRecord(_arg_1:IFilter):Record
        {
            var _local_2:RecordSet;
            var _local_3:Record;
            _local_2 = getRecordSet(_arg_1);
            while (_local_2.hasNext())
            {
                return (_local_2.next());
            };
            return (_local_3);
        }

        public function getIdxFromKeyValue(_arg_1:String, _arg_2:Object):int
        {
            var _local_3:Number;
            var _local_4:Array;
            var _local_5:int;
            if (indexesObj[_arg_1])
            {
                _local_3 = indexesObj[_arg_1][_arg_2];
                if (!isNaN(_local_3))
                {
                    return (int(_local_3));
                };
            }
            else
            {
                _local_4 = dataObj[_arg_1];
                _local_5 = 0;
                while (_local_5 < numRecords)
                {
                    if (_local_4[_local_5] == _arg_2)
                    {
                        return (_local_5);
                    };
                    _local_5++;
                };
            };
            return (-1);
        }

        public function traceSchema():*
        {
            var _local_1:String;
            for (_local_1 in schemaObj)
            {
            };
        }

        public function insertValue(_arg_1:Object, _arg_2:Number, _arg_3:String):*
        {
            var _local_4:Array;
            _local_4 = dataObj[_arg_3];
            if (!_local_4)
            {
                return;
            };
            _local_4[_arg_2] = _arg_1;
        }

        public function insertCalculatedValues(_arg_1:String, _arg_2:String, _arg_3:IExpression):Boolean
        {
            var _local_4:int;
            var _local_5:Object;
            if (!fieldExists(_arg_1))
            {
                addField(_arg_1, _arg_2);
            };
            _local_4 = 0;
            while (_local_4 < numRecords)
            {
                _local_5 = _arg_3.procRow(_local_4);
                insertValue(_local_5, _local_4, _arg_1);
                _local_4++;
            };
            return (true);
        }

        public function addField(_arg_1:String, _arg_2:String):Array
        {
            var _local_3:Array;
            var _local_4:int;
            if (fieldExists(_arg_1))
            {
                return ([]);
            };
            schemaObj[_arg_1] = _arg_2;
            _local_3 = (dataObj[_arg_1] = new Array(numRecords));
            _local_4 = 0;
            while (_local_4 < numRecords)
            {
                if (_arg_2 == STRING)
                {
                    _local_3[_local_4] = "";
                }
                else
                {
                    _local_3[_local_4] = null;
                };
                _local_4++;
            };
            return (_local_3);
        }

        public function get length():int
        {
            return (numRecords);
        }

        public function getNumber(_arg_1:Number, _arg_2:String):Number
        {
            var _local_3:Object;
            _local_3 = getAttributeValue(_arg_1, _arg_2);
            if (_local_3 === null)
            {
                return (NaN);
            };
            return (Number(_local_3));
        }

        public function getProjectedPoint(_arg_1:int):ProjectedPoint
        {
            return (null);
        }

        public function joinMatchingFields(_arg_1:String, _arg_2:DataSource, _arg_3:Array, _arg_4:String=null):*
        {
            var _local_5:Array;
            var _local_6:String;
            var _local_7:String;
            var _local_8:int;
            var _local_9:Array;
            var _local_10:Array;
            var _local_11:int;
            var _local_12:Boolean;
            var _local_13:String;
            var _local_14:String;
            var _local_15:String;
            var _local_16:int;
            var _local_17:int;
            var _local_18:Object;
            var _local_19:int;
            var _local_20:int;
            var _local_21:Object;
            if (((!(this.ready)) || (!(_arg_2.ready))))
            {
                return;
            };
            _local_5 = _arg_1.split(":");
            if (_local_5.length != 2)
            {
                return;
            };
            _local_6 = _local_5[0];
            _local_7 = _local_5[1];
            if (!fieldExists(_local_7))
            {
                return;
            };
            if (!_arg_2.fieldExists(_local_6))
            {
                return;
            };
            _local_8 = _arg_3.length;
            _local_9 = [];
            _local_10 = [];
            _local_11 = 0;
            while (_local_11 < _local_8)
            {
                _local_5 = _arg_3[_local_11].split(":");
                _local_10.push(_local_5[0]);
                if (_local_5.length >= 2)
                {
                    _local_9.push(_local_5[1]);
                }
                else
                {
                    _local_9.push(_local_5[0]);
                };
                _local_11++;
            };
            _local_12 = _arg_2.buildConditionalIndex(_local_6, _arg_4);
            if (!_local_12)
            {
                return (false);
            };
            _local_16 = 0;
            while (_local_16 < _local_8)
            {
                _local_13 = _local_10[_local_16];
                _local_14 = _local_9[_local_16];
                _local_15 = _arg_2.getFieldType(_local_13);
                if (_local_15 != null)
                {
                    if (dataObj[_local_14] === undefined)
                    {
                        addField(_local_14, _local_15);
                    };
                };
                _local_16++;
            };
            _local_17 = 0;
            while (_local_17 < numRecords)
            {
                _local_18 = dataObj[_local_7][_local_17];
                _local_19 = _arg_2.getIdxFromKeyValue(_local_6, _local_18);
                if (_local_19 != -1)
                {
                    _local_20 = 0;
                    while (_local_20 < _local_8)
                    {
                        _local_14 = _local_9[_local_20];
                        _local_13 = _local_10[_local_20];
                        _local_21 = _arg_2.getAttributeValue(_local_19, _local_13);
                        dataObj[_local_14][_local_17] = _local_21;
                        _local_20++;
                    };
                };
                _local_17++;
            };
            return (true);
        }

        public function loadPagedTabData(_arg_1:String, _arg_2:String, _arg_3:Number):*
        {
            tabDataLoader = new TabDataLoader(_arg_1, schemaObj);
            this.addDependency(tabDataLoader);
            this.monitorDependencies();
            tabDataLoader.loadPages(_arg_2, _arg_3);
        }

        public function getRecordIds():Array
        {
            var _local_1:Array;
            var _local_2:int;
            _local_1 = new Array(numRecords);
            _local_2 = 0;
            while (_local_2 < numRecords)
            {
                _local_1[_local_2] = _local_2;
                _local_2++;
            };
            return (_local_1);
        }

        public function getFieldArray(_arg_1:String):Array
        {
            if (!fieldExists(_arg_1))
            {
                return ([]);
            };
            return (dataObj[_arg_1]);
        }

        public function fieldExists(_arg_1:String):Boolean
        {
            var _local_2:Boolean;
            return ((dataObj[_arg_1]) ? true : false);
        }

        public function getIdByKey(_arg_1:String, _arg_2:Object):int
        {
            var _local_3:Array;
            var _local_4:int;
            if (!fieldExists(_arg_1))
            {
                return (-1);
            };
            _local_3 = dataObj[_arg_1];
            _local_4 = 0;
            while (_local_4 < numRecords)
            {
                if (_local_3[_local_4] == _arg_2)
                {
                    return (_local_4);
                };
                _local_4++;
            };
            return (-1);
        }

        public function buildConditionalIndex(_arg_1:String, _arg_2:String=null):Boolean
        {
            var _local_3:Expression;
            var _local_4:Boolean;
            var _local_5:Array;
            var _local_6:Object;
            var _local_7:int;
            var _local_8:Object;
            var _local_9:String;
            var _local_10:Object;
            _local_4 = false;
            if (_arg_2)
            {
                _local_3 = new Expression(_arg_2, this);
                _local_4 = true;
            };
            if (indexesObj[_arg_1])
            {
                delete indexesObj[_arg_1];
            };
            _local_5 = dataObj[_arg_1];
            if (!_local_5)
            {
                return (false);
            };
            _local_6 = {};
            _local_7 = 0;
            for (;_local_7 < numRecords;_local_7++)
            {
                _local_8 = _local_5[_local_7];
                if (_local_8)
                {
                    _local_9 = String(_local_8);
                    if (_local_9)
                    {
                        if (_local_4)
                        {
                            _local_10 = _local_3.procRow(_local_7);
                            if (!_local_10) continue;
                        };
                        if (!_local_6[_local_9])
                        {
                            _local_6[_local_9] = _local_7;
                        };
                    };
                };
            };
            indexesObj[_arg_1] = _local_6;
            return (true);
        }

        override protected function handleReadyState():*
        {
            if (tabDataLoader)
            {
                dataObj = tabDataLoader.data;
                numRecords = tabDataLoader.numRecords;
                if ((((!(dataObj)) || (!(schemaObj))) || (numRecords <= 0)))
                {
                };
            };
        }

        public function snatchValue(_arg_1:int, _arg_2:String):Object
        {
            return (dataObj[_arg_2][_arg_1]);
        }

        public function deleteIndex(_arg_1:String):*
        {
            if (indexesObj[_arg_1])
            {
                delete indexesObj[_arg_1];
            };
        }


    }
}//package mb

