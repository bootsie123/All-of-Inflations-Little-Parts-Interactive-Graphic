// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.ProjectedPoint

package mb
{
    public class ProjectedPoint 
    {

        public var x:Number;
        public var y:Number;

        public function ProjectedPoint(_arg_1:Number, _arg_2:Number)
        {
            this.x = _arg_1;
            this.y = _arg_2;
        }

        internal function get key():String
        {
            var _local_1:String;
            return ((String(x) + ":") + String(y));
        }


    }
}//package mb

