// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.projections.IProjection

package mb.projections
{
    import flash.geom.Point;

    public interface IProjection 
    {

        function unproject(_arg_1:Number, _arg_2:Number):Point;
        function project(_arg_1:Number, _arg_2:Number):Point;

    }
}//package mb.projections

