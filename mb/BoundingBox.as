// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.BoundingBox

package mb
{
    import flash.geom.Rectangle;

    public class BoundingBox 
    {

        protected var _box:Rectangle;

        protected var _left:Number = 0;
        protected var _top:Number = 0;
        protected var _right:Number = 0;
        protected var _bottom:Number = 0;
        protected var _hasBounds:Boolean = false;

        public function BoundingBox(_arg_1:Number=NaN, _arg_2:Number=NaN, _arg_3:Number=NaN, _arg_4:Number=NaN)
        {
            if (isNaN(_arg_4))
            {
                _hasBounds = false;
            }
            else
            {
                setBounds(_arg_1, _arg_2, _arg_3, _arg_4);
            };
        }

        public function get left():*
        {
            return (_left);
        }

        public function get top():*
        {
            return (_top);
        }

        public function traceBounds():*
        {
        }

        public function get right():*
        {
            return (_right);
        }

        public function get bottom():*
        {
            return (_bottom);
        }

        public function get hasBounds():Boolean
        {
            return (_hasBounds);
        }

        public function containsPoint(_arg_1:Number, _arg_2:Number):Boolean
        {
            if (!_hasBounds)
            {
                return (false);
            };
            if (((_arg_1 > _left) && (_arg_1 < _right)))
            {
                if (((_arg_2 < _top) && (_arg_2 > _bottom)))
                {
                    return (true);
                };
            };
            return (false);
        }

        public function intersects(_arg_1:BoundingBox):Boolean
        {
            if (!_hasBounds)
            {
                return (false);
            };
            if (((_arg_1.left < _right) && (_arg_1.right > _left)))
            {
                if (((_arg_1.top > _bottom) && (_arg_1.bottom < _top)))
                {
                    return (true);
                };
            };
            return (false);
        }

        public function setBounds(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):*
        {
            _left = _arg_1;
            _top = _arg_2;
            _right = _arg_3;
            _bottom = _arg_4;
            _hasBounds = true;
        }

        public function merge(_arg_1:BoundingBox):*
        {
            if (!_arg_1.hasBounds)
            {
                return;
            };
            if (_hasBounds)
            {
                if (_left > _arg_1.left)
                {
                    _left = _arg_1.left;
                };
                if (_top < _arg_1.top)
                {
                    _top = _arg_1.top;
                };
                if (_right < _arg_1.right)
                {
                    _right = _arg_1.right;
                };
                if (_bottom > _arg_1.bottom)
                {
                    _bottom = _arg_1.bottom;
                };
            }
            else
            {
                setBounds(_arg_1.left, _arg_1.top, _arg_1.right, _arg_1.bottom);
            };
        }

        public function mergePoint(_arg_1:Number, _arg_2:Number):*
        {
            if (_hasBounds)
            {
                if (_arg_1 < _left)
                {
                    _left = _arg_1;
                }
                else
                {
                    if (_arg_1 > _right)
                    {
                        _right = _arg_1;
                    };
                };
                if (_arg_2 < _bottom)
                {
                    _bottom = _arg_2;
                }
                else
                {
                    if (_arg_2 > _top)
                    {
                        _top = _arg_2;
                    };
                };
            }
            else
            {
                setBounds(_arg_1, _arg_2, _arg_1, _arg_2);
            };
        }


    }
}//package mb

