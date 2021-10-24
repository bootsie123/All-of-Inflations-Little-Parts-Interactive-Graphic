// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.symbols.ShapeVector

package mb.symbols
{
    import mb.BoundingBox;
    import mb.ColorScheme;
    import flash.geom.Point;
    import mb.XY;
    import flash.display.Sprite;

    public class ShapeVector extends BoundingBox 
    {

        internal var _col:ColorScheme;
        internal var _sid:int;
        internal var _parts:Array;

        public function ShapeVector(_arg_1:int)
        {
            _parts = [];
            _sid = _arg_1;
        }

        public function get id():int
        {
            return (_sid);
        }

        public function drawShapeVectors(_arg_1:XY, _arg_2:Sprite):*
        {
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:Point;
            var _local_8:int;
            var _local_9:int;
            var _local_10:PartVertexSet;
            _local_3 = _arg_1.mxProjToScreen;
            _local_4 = _arg_1.myProjToScreen;
            _local_5 = _arg_1.bxProjToScreen;
            _local_6 = _arg_1.byProjToScreen;
            _local_8 = _parts.length;
            _local_9 = 0;
            while (_local_9 < _local_8)
            {
                _local_10 = _parts[_local_9];
                if (_local_10.hasNext())
                {
                    _local_7 = _local_10.next();
                    _arg_2.graphics.moveTo(((_local_7.x * _local_3) + _local_5), ((_local_7.y * _local_4) + _local_6));
                };
                while (_local_10.hasNext())
                {
                    _local_7 = _local_10.next();
                    _arg_2.graphics.lineTo(((_local_7.x * _local_3) + _local_5), ((_local_7.y * _local_4) + _local_6));
                };
                _local_10.reset();
                _local_9++;
            };
        }

        public function addPartData(_arg_1:PartVertexSet):*
        {
            merge(_arg_1);
            _parts.push(_arg_1);
        }


    }
}//package mb.symbols

