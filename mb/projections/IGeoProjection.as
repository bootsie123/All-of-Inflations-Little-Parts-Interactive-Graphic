// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.projections.IGeoProjection

package mb.projections
{
    import flash.geom.Point;

    public interface IGeoProjection extends IProjection 
    {

        function reprojectFast(_arg_1:Number, _arg_2:Number, _arg_3:Projection):Point;
        function compare(_arg_1:IGeoProjection):Boolean;
        function reproject(_arg_1:Number, _arg_2:Number, _arg_3:Projection):Point;
        function get name():String;
        function projectFast(_arg_1:Number, _arg_2:Number):Point;
        function unprojectFast(_arg_1:Number, _arg_2:Number):Point;

    }
}//package mb.projections

