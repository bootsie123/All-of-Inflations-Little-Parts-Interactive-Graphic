// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.XY

package mb
{
    import flash.geom.Point;

    public class XY 
    {

        private static var _p:Point = new Point();

        private var _mxProj:Number = 1;
        private var _myProj:Number = 1;
        private var _bxProj:Number = 0;
        private var _byProj:Number = 0;
        private var _scale:Number = 1;

        public function XY(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number)
        {
            _mxProj = _arg_1;
            _myProj = _arg_2;
            _bxProj = _arg_3;
            _byProj = _arg_4;
        }

        public function setContainerScale(_arg_1:Number):*
        {
            _scale = _arg_1;
        }

        public function get bxProjToScreen():Number
        {
            return (_bxProj);
        }

        public function get scale():Number
        {
            return (_scale);
        }

        public function screenToProj(_arg_1:Number, _arg_2:Number):Point
        {
            _p.x = ((_arg_1 - _bxProj) / _mxProj);
            _p.y = ((_arg_2 - _byProj) / _myProj);
            return (_p);
        }

        public function get myProjToScreen():Number
        {
            return (_myProj);
        }

        public function get byProjToScreen():Number
        {
            return (_byProj);
        }

        public function projToScreen(_arg_1:Number, _arg_2:Number):Point
        {
            _p.x = ((_arg_1 * _mxProj) + _bxProj);
            _p.y = ((_arg_2 * _myProj) + _byProj);
            return (_p);
        }

        public function get mxProjToScreen():Number
        {
            return (_mxProj);
        }


    }
}//package mb

