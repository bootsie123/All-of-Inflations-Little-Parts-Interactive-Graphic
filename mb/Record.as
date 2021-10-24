// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.Record

package mb
{
    public class Record 
    {

        private var _data:DataSource;
        private var _rid:int;

        public function Record(_arg_1:DataSource, _arg_2:int)
        {
            _data = _arg_1;
            _rid = _arg_2;
        }

        public function getString(_arg_1:String):String
        {
            return (_data.getString(_rid, _arg_1));
        }

        public function getNumber(_arg_1:String):Number
        {
            return (_data.getNumber(_rid, _arg_1));
        }

        public function get id():int
        {
            return (_rid);
        }


    }
}//package mb

