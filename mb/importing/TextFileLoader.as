// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.importing.TextFileLoader

package mb.importing
{
    import mb.Notifier;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.net.URLRequestHeader;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;

    public class TextFileLoader extends Notifier 
    {

        private static const CR:String = "\r";
        private static const LF:String = "\n";
        private static const CRLF:String = "\r\n";
        private static const DELIMITER:String = "\t";
        public static const LOAD:String = "load";

        private var _noCache:Boolean = false;
        private var myLoader:URLLoader;
        protected var URL:String;

        public function TextFileLoader(_arg_1:String, _arg_2:Boolean=false)
        {
            this.URL = _arg_1;
            _noCache = _arg_2;
        }

        public static function cleanString(_arg_1:String):String
        {
            var _local_2:Number;
            _local_2 = (_arg_1.length - 1);
            while (_arg_1.charAt(0) == " ")
            {
                _arg_1 = _arg_1.substr(1);
                _local_2--;
            };
            while (_arg_1.charAt(_local_2) == " ")
            {
                _arg_1 = _arg_1.slice(0, -1);
                _local_2--;
            };
            if (((_arg_1.charAt(0) == '"') && (_arg_1.charAt(_local_2) == '"')))
            {
                _arg_1 = _arg_1.slice(1, -1);
            };
            return (_arg_1);
        }


        public function load():*
        {
            var _local_1:URLRequest;
            var _local_2:URLRequestHeader;
            myLoader = new URLLoader();
            myLoader.addEventListener(Event.COMPLETE, handleLoadComplete);
            myLoader.addEventListener(IOErrorEvent.IO_ERROR, handleLoadFailure);
            myLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleLoadFailure);
            _local_1 = new URLRequest(URL);
            if (_noCache)
            {
                _local_2 = new URLRequestHeader("pragma", "no-cache");
                _local_1.requestHeaders.push(_local_2);
            };
            myLoader.load(_local_1);
        }

        public function get url():String
        {
            return (URL);
        }

        private function handleLoadComplete(_arg_1:Event):*
        {
            var _local_2:String;
            var _local_3:Object;
            var _local_4:String;
            var _local_5:Boolean;
            var _local_6:Boolean;
            var _local_7:Array;
            _local_2 = String(myLoader.data);
            if (!_local_2)
            {
                _local_3 = null;
            }
            else
            {
                _local_4 = CR;
                _local_5 = (_local_2.indexOf(CR) > -1);
                _local_6 = (_local_2.indexOf(LF) > -1);
                if (((_local_5) && (_local_6)))
                {
                    _local_4 = CRLF;
                }
                else
                {
                    if (_local_5)
                    {
                        _local_4 = CR;
                    }
                    else
                    {
                        if (_local_6)
                        {
                            _local_4 = LF;
                        }
                        else
                        {
                            return (null);
                        };
                    };
                };
                _local_7 = _local_2.split(_local_4);
                _local_3 = parseData(_local_7);
            };
            notify(null, LOAD);
        }

        private function handleLoadFailure(_arg_1:Event):*
        {
            notify(null, LOAD);
        }

        protected function parseData(_arg_1:Array):Object
        {
            return (null);
        }


    }
}//package mb.importing

