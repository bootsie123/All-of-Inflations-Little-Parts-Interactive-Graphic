// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.importing.TabDataLoader

package mb.importing
{
    import mb.DataSource;
    import mb.Util;
    import mb.*;

    public class TabDataLoader extends TextFileLoader 
    {

        private var _schemaObj:Object;
        private var _fieldIndexObj:Object;
        private var _dataObj:Object;

        private var _importedRecords:int = 0;
        private var _numFields:int = 0;
        private var pageStr:String = "";
        private var pageSize:Number = 0;
        private var pageBaseURL:String = "";
        private var currPage:Number = 0;
        private var _currPageNumLines:Number = 0;

        public function TabDataLoader(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_3);
            _schemaObj = _arg_2;
        }

        private static function convertValue(_arg_1:String, _arg_2:String):Object
        {
            var _local_3:Object;
            var _local_4:Number;
            if (_arg_1 === "")
            {
                _local_3 = null;
            }
            else
            {
                if (_arg_2 == DataSource.STRING)
                {
                    _local_3 = Object(_arg_1);
                }
                else
                {
                    if (((_arg_2 == DataSource.DOUBLE) || (_arg_2 == DataSource.INTEGER)))
                    {
                        _local_4 = Number(_arg_1);
                        if (isNaN(_local_4))
                        {
                            _local_3 = null;
                        }
                        else
                        {
                            _local_3 = Object(_local_4);
                        };
                    }
                    else
                    {
                        if (_arg_2 == DataSource.DATE)
                        {
                            _local_3 = Object(Util.strToDate(_arg_1));
                        }
                        else
                        {
                            _local_3 = null;
                        };
                    };
                };
            };
            return (_local_3);
        }


        public function loadPages(_arg_1:String, _arg_2:Number):*
        {
            this.pageSize = _arg_2;
            this.pageStr = _arg_1;
            pageBaseURL = URL;
            loadDataPage(1);
        }

        private function handlePagedTabData(_arg_1:Object):*
        {
            if (_currPageNumLines == 0)
            {
                if (currPage == 1)
                {
                };
                notifyReady();
                return;
            };
            if (_currPageNumLines >= pageSize)
            {
                loadDataPage((currPage + 1));
            }
            else
            {
                notifyReady();
            };
        }

        public function get data():Object
        {
            return (_dataObj);
        }

        override public function load():*
        {
            this.setCallback(this, notifyReady, TextFileLoader.LOAD);
            super.load();
        }

        public function get schema():Object
        {
            return (_schemaObj);
        }

        public function get numRecords():int
        {
            return (_importedRecords);
        }

        private function loadDataPage(_arg_1:Number):*
        {
            var _local_2:String;
            currPage = _arg_1;
            _local_2 = ((pageBaseURL.indexOf("?") == -1) ? ((("?" + pageStr) + "=") + currPage) : ((("&" + pageStr) + "=") + currPage));
            URL = (pageBaseURL + _local_2);
            this.setCallback(this, handlePagedTabData, TextFileLoader.LOAD);
            super.load();
        }

        override protected function parseData(_arg_1:Array):Object
        {
            var _local_2:int;
            var _local_3:String;
            var _local_4:String;
            var _local_5:int;
            var _local_6:int;
            var _local_7:Array;
            var _local_8:String;
            var _local_9:Number;
            var _local_10:int;
            var _local_11:Array;
            if (!_schemaObj)
            {
                return (null);
            };
            _local_2 = (_arg_1.length - 1);
            if (!_fieldIndexObj)
            {
                _local_11 = _arg_1[0].split("\t");
                _numFields = _local_11.length;
                _fieldIndexObj = {};
                _dataObj = {};
                _local_5 = 0;
                while (_local_5 < _numFields)
                {
                    _local_4 = cleanString(_local_11[_local_5]);
                    if (_schemaObj[_local_4])
                    {
                        _fieldIndexObj[_local_4] = _local_5;
                        _local_3 = _schemaObj[_local_4];
                        _dataObj[_local_4] = [];
                    };
                    _local_5++;
                };
            };
            _local_6 = 0;
            _local_10 = 1;
            while (_local_10 <= _local_2)
            {
                _local_8 = _arg_1[_local_10];
                if (_local_8)
                {
                    _local_6++;
                };
                _local_7 = _local_8.split("\t");
                if (_local_7.length == _numFields)
                {
                    for (_local_4 in _fieldIndexObj)
                    {
                        _local_9 = _fieldIndexObj[_local_4];
                        _local_3 = _schemaObj[_local_4];
                        if (_local_3 != null)
                        {
                            _dataObj[_local_4][_importedRecords] = convertValue(_local_7[_local_9], _local_3);
                        };
                    };
                    _importedRecords++;
                };
                _local_10++;
            };
            _currPageNumLines = _local_6;
            return ({});
        }


    }
}//package mb.importing

