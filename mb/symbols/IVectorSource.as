// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.symbols.IVectorSource

package mb.symbols
{
    import mb.INotifier;
    import mb.BoundingBox;
    import mb.ScaledBoundingBox;
    import mb.projections.Projection;

    public interface IVectorSource extends INotifier 
    {

        function fetchIdsByPointTest(_arg_1:Number, _arg_2:Number):SymbolSet;
        function fetchAllIds():SymbolSet;
        function get bounds():BoundingBox;
        function fetchIdsByBoundsTest(_arg_1:ScaledBoundingBox):SymbolSet;
        function set projection(_arg_1:Projection):*;

    }
}//package mb.symbols

