// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.placement.ShapeLayerAlignment

package mb.placement
{
    import mb.symbols.IShapeSource;
    import mb.Notifier;
    import flash.display.MovieClip;
    import mb.projections.Projection;
    import mb.BoundingBox;

    public class ShapeLayerAlignment extends Alignment 
    {

        private var _shapes:IShapeSource;

        public function ShapeLayerAlignment(_arg_1:MovieClip, _arg_2:Projection, _arg_3:IShapeSource, _arg_4:Array=null, _arg_5:String=null)
        {
            super(_arg_1, _arg_2);
            if (_arg_4)
            {
                _marginLeft = _arg_4[0];
                _marginTop = _arg_4[1];
                _marginRight = _arg_4[2];
                _marginBottom = _arg_4[3];
            };
            if (_arg_5)
            {
                _alignStr = _arg_5;
            };
            _shapes = _arg_3;
            _shapes.setCallback(this, catchVectorData, Notifier.READY);
        }

        private function catchVectorData(_arg_1:Object):*
        {
            var _local_2:BoundingBox;
            _local_2 = _shapes.bounds;
            _projLeftOrig = _local_2.left;
            _projTopOrig = _local_2.top;
            _projBottomOrig = _local_2.bottom;
            _projRightOrig = _local_2.right;
            init();
        }


    }
}//package mb.placement

