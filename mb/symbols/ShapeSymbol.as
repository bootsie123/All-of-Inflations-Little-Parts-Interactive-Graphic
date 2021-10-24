// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.symbols.ShapeSymbol

package mb.symbols
{
    import mb.ColorScheme;
    import flash.display.Sprite;
    import mb.XY;

    public class ShapeSymbol implements ISymbol 
    {

        internal var _col:ColorScheme;
        internal var _sid:int;
        internal var _vec:ShapeVector;
        internal var _sp:Sprite;

        public function ShapeSymbol(_arg_1:int, _arg_2:ShapeVector)
        {
            _sid = _arg_1;
            _vec = _arg_2;
        }

        public function updatePlacement(_arg_1:XY):*
        {
            if (((!(_col)) || (!(_sp))))
            {
                return;
            };
            _col.rid = _sid;
            if (_col.haveStroke)
            {
                _sp.graphics.lineStyle(_col.strokeWeight, _col.strokeColor, _col.strokeAlpha, false, "none");
            };
            if (_col.haveFill)
            {
                _sp.graphics.beginFill(_col.fillColor, _col.fillAlpha);
            };
            _vec.drawShapeVectors(_arg_1, _sp);
            _sp.graphics.endFill();
            if (_col.haveFill)
            {
                _sp.graphics.endFill();
            };
        }

        public function embed(_arg_1:Sprite, _arg_2:ColorScheme):*
        {
            _sp = _arg_1;
            _col = _arg_2;
        }

        public function get id():int
        {
            return (_sid);
        }


    }
}//package mb.symbols

