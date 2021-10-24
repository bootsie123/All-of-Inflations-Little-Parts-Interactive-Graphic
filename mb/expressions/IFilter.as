// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.expressions.IFilter

package mb.expressions
{
    public interface IFilter 
    {

        function addNumericMatch(_arg_1:String, _arg_2:Number):*;
        function clearFilter(_arg_1:String):*;
        function filterRows(_arg_1:Array=null):Array;
        function setStringMatch(_arg_1:String, _arg_2:String):*;
        function addStringMatch(_arg_1:String, _arg_2:String):*;
        function setNumericRange(_arg_1:String, _arg_2:Number, _arg_3:Number):*;
        function setNumericMatch(_arg_1:String, _arg_2:Number):*;
        function haveMatch(_arg_1:int):Boolean;

    }
}//package mb.expressions

