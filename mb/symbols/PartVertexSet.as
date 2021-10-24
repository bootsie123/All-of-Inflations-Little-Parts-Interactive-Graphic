// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.symbols.PartVertexSet

package mb.symbols
{
    import mb.BoundingBox;
    import flash.geom.Point;

    public class PartVertexSet extends BoundingBox implements IVertexSet 
    {

        private static var _xy:Point = new Point();
        private static var _pp:Point;

        private var _numArcs:int = 0;
        private var _currArc:IVertexSet;
        private var arcArr:Array;
        private var _currArcIdx:int = 0;

        public function PartVertexSet()
        {
            arcArr = [];
        }

        public function next():Point
        {
            _pp = _currArc.next();
            _xy.x = _pp.x;
            _xy.y = _pp.y;
            return (_xy);
        }

        public function addArcVertices(_arg_1:ArcVertexSet):*
        {
            arcArr.push(_arg_1);
            _numArcs++;
            if (_numArcs == 1)
            {
                _currArc = _arg_1;
            };
            merge(_arg_1);
        }

        public function reset():*
        {
            var _local_1:int;
            _currArcIdx = 0;
            _local_1 = 0;
            while (_local_1 < _numArcs)
            {
                arcArr[_local_1].reset();
                _local_1++;
            };
            if (_numArcs > 0)
            {
                _currArc = arcArr[0];
            };
        }

        public function hasNext():Boolean
        {
            if (_currArcIdx >= _numArcs)
            {
                return (false);
            };
            if (_currArc.hasNext())
            {
                return (true);
            };
            _currArcIdx++;
            while (_currArcIdx < _numArcs)
            {
                _currArc = arcArr[_currArcIdx];
                if (_currArc.hasNext())
                {
                    return (true);
                };
                _currArcIdx++;
            };
            return (false);
        }


    }
}//package mb.symbols

