// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.symbols.ISymbolManager

package mb.symbols
{
    import mb.expressions.IFilter;
    import mb.ColorScheme;

    public interface ISymbolManager 
    {

        function updateSymbolPlacement(_arg_1:Boolean=false):*;
        function setFilter(_arg_1:IFilter):*;
        function clearSymbols():*;
        function setStyle(_arg_1:ColorScheme):*;
        function updateSymbolStyle(_arg_1:Boolean=false):*;
        function fetchNewSymbols():SymbolSet;
        function fetchMouseoverId():int;
        function fetchActiveSymbols():SymbolSet;

    }
}//package mb.symbols

