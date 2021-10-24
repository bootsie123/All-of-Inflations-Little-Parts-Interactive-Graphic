// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.symbols.ShapeCache

package mb.symbols
{
    public class ShapeCache 
    {

        private var idArr:Array;
        private var indexArr:Array;

        public function ShapeCache()
        {
            indexArr = [];
            idArr = [];
        }

        public function addShape(_arg_1:ShapeVector):*
        {
            indexArr[_arg_1.id] = _arg_1;
            idArr.push(_arg_1.id);
        }

        public function hasShape(_arg_1:int):*
        {
            return (!(indexArr[_arg_1] === undefined));
        }

        public function getShape(_arg_1:int):ShapeVector
        {
            return (indexArr[_arg_1]);
        }

        public function getAllIds():Array
        {
            return (idArr);
        }


    }
}//package mb.symbols

