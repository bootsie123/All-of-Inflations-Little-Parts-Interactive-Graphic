// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.ResultSet

package mb
{
    public class ResultSet 
    {

        public const DESCENDING:String = "desc";
        public const ASCENDING:String = "asc";

        internal var _data:DataSource;
        internal var _ids:Array;

        public function ResultSet(_arg_1:DataSource, _arg_2:Array=null)
        {
            if (!_arg_2)
            {
                _arg_2 = [];
            };
            _ids = _arg_2;
            _data = _arg_1;
        }

        public function get size():int
        {
            return (_ids.length);
        }

        public function fetchFirstId():int
        {
            if (_ids.length == 0)
            {
                return (-1);
            };
            return (_ids[0]);
        }

        public function setIds(_arg_1:Array):*
        {
            _ids = _arg_1;
        }

        public function fetchAssoc(_arg_1:int=0):Object
        {
            return (_data.getAssocRecord(_arg_1));
        }

        public function fetchIds():Array
        {
            return (_ids);
        }


    }
}//package mb

