// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.RecordSet

package mb
{
    public class RecordSet extends IdSet 
    {

        private var _data:DataSource;

        public function RecordSet(_arg_1:DataSource, _arg_2:Array)
        {
            super(_arg_2);
            _data = _arg_1;
        }

        public function next():Record
        {
            return (new Record(_data, nextId()));
        }


    }
}//package mb

