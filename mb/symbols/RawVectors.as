// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.symbols.RawVectors

package mb.symbols
{
    import mb.Notifier;
    import mb.projections.Projection;

    public class RawVectors extends Notifier 
    {

        protected var _nativeProj:Projection;
        protected var _reproject:Boolean = false;
        protected var _project:Boolean = false;
        protected var _url:String;
        protected var _types:uint;

        public function RawVectors(_arg_1:String, _arg_2:Projection, _arg_3:uint)
        {
            _url = _arg_1;
            _types = _arg_3;
            _nativeProj = _arg_2;
            load();
        }

        protected function testType(_arg_1:uint):Boolean
        {
            return (Boolean((_arg_1 & _types)));
        }

        protected function load():*
        {
        }

        public function fetchProjectedArcs(_arg_1:Projection):Array
        {
            if (!this.ready)
            {
                return ([]);
            };
            return (extractProjectedArcs(_arg_1));
        }

        protected function numVectors(_arg_1:uint):int
        {
            return (0);
        }

        protected function extractProjectedArcs(_arg_1:Projection):*
        {
            return ([]);
        }


    }
}//package mb.symbols

