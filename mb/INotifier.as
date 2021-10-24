// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.INotifier

package mb
{
    public interface INotifier 
    {

        function get ready():Boolean;
        function unsetCallback(_arg_1:Object, _arg_2:String):Boolean;
        function setCallback(_arg_1:Object, _arg_2:Function, _arg_3:String):*;
        function haveCallback(_arg_1:String):Boolean;

    }
}//package mb

