// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.symbols.ArcVertexSet

package mb.symbols
{
    import mb.BoundingBox;
    import flash.geom.Point;

    public class ArcVertexSet extends BoundingBox implements IVertexSet 
    {

        public static const FORWARD:Boolean = true;
        public static const BACKWARD:Boolean = false;

        private var _direction:Boolean;
        private var _yy:Array;
        private var _p:Point;
        private var _idx:int;
        private var _xx:Array;
        private var _len:int;
        private var _inc:int;
        protected var orderArray:Array;

        public function ArcVertexSet(_arg_1:Array, _arg_2:Array, _arg_3:Boolean)
        {
            _xx = _arg_1;
            _yy = _arg_2;
            _len = _arg_1.length;
            _direction = _arg_3;
            _inc = ((_arg_3 == FORWARD) ? 1 : -1);
            _p = new Point();
            reset();
        }

        public function next():Point
        {
            _p.x = _xx[_idx];
            _p.y = _yy[_idx];
            _idx = (_idx + _inc);
            return (_p);
        }

        public function reset():*
        {
            _idx = ((_direction == FORWARD) ? 0 : (_len - 1));
        }

        public function hasNext():Boolean
        {
            return ((_direction == FORWARD) ? (_idx < _len) : (_idx > 0));
        }


    }
}//package mb.symbols

