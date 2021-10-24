// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.MapInfo

package mb
{
    import mb.projections.Projection;

    public class MapInfo 
    {

        private var _stack:MapStack;

        public function MapInfo(_arg_1:MapStack)
        {
            _stack = _arg_1;
        }

        public function get layers():LayerManager
        {
            return (_stack.layers);
        }

        public function get ready():Boolean
        {
            return (_stack.ready);
        }

        public function get mouse():MouseService
        {
            return (_stack.mouse);
        }

        public function get hidden():Boolean
        {
            return (_stack.hidden);
        }

        public function get projection():Projection
        {
            return (_stack.projection);
        }

        public function get navigation():NavigationManager
        {
            return (_stack.navigation);
        }


    }
}//package mb

