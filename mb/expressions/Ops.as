// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.expressions.Ops

package mb.expressions
{
    public class Ops 
    {


        public static function sub(_arg_1:Number, _arg_2:Number):Number
        {
            return (_arg_1 - _arg_2);
        }

        public static function add(_arg_1:Number, _arg_2:Number):Number
        {
            return (_arg_1 + _arg_2);
        }

        public static function or(_arg_1:Object, _arg_2:Object):Number
        {
            return (Number(((_arg_1) || (_arg_2))));
        }

        public static function mul(_arg_1:Number, _arg_2:Number):Number
        {
            return (_arg_1 * _arg_2);
        }

        public static function lesser(_arg_1:Number, _arg_2:Number):Number
        {
            return ((_arg_1 < _arg_2) ? _arg_1 : _arg_2);
        }

        public static function lt(_arg_1:Object, _arg_2:Object):Number
        {
            return (Number((_arg_1 < _arg_2)));
        }

        public static function greater(_arg_1:Number, _arg_2:Number):Number
        {
            return ((_arg_1 > _arg_2) ? _arg_1 : _arg_2);
        }

        public static function avg(_arg_1:Array):Number
        {
            var _local_2:int;
            var _local_3:Number;
            _local_2 = _arg_1.length;
            if (_local_2 == 0)
            {
                return (0);
            };
            _local_3 = calcGreedy(_arg_1, add);
            return (_local_3 / _local_2);
        }

        public static function max(_arg_1:Array):Number
        {
            return (calcGreedy(_arg_1, greater));
        }

        public static function eq(_arg_1:Object, _arg_2:Object):Number
        {
            return (Number((_arg_1 == _arg_2)));
        }

        public static function gt(_arg_1:Object, _arg_2:Object):Number
        {
            return (Number((_arg_1 > _arg_2)));
        }

        public static function nop(_arg_1:Object, _arg_2:Object):Number
        {
            return (NaN);
        }

        private static function calcRank(_arg_1:Array, _arg_2:int):Number
        {
            var _local_3:int;
            var _local_4:Number;
            _local_3 = _arg_1.length;
            if (_local_3 <= 1)
            {
                return (0);
            };
            _arg_1.sort((Array.NUMERIC | Array.DESCENDING));
            if (((_arg_2 > 0) && (_arg_2 <= _local_3)))
            {
                _local_4 = Number(_arg_1[(_arg_2 - 1)]);
            }
            else
            {
                if (((_arg_2 < 0) && (_arg_2 >= -(_local_3))))
                {
                    _local_4 = Number(_arg_1[(_local_3 + _arg_2)]);
                }
                else
                {
                    _local_4 = NaN;
                };
            };
            return (_local_4);
        }

        public static function div(_arg_1:Number, _arg_2:Number):Number
        {
            return (_arg_1 / _arg_2);
        }

        public static function min(_arg_1:Array):Number
        {
            return (calcGreedy(_arg_1, lesser));
        }

        public static function rank(_arg_1:Array):Number
        {
            var _local_2:int;
            _local_2 = _arg_1.shift();
            return (calcRank(_arg_1, _local_2));
        }

        private static function calcGreedy(_arg_1:Array, _arg_2:Function):Number
        {
            var _local_3:int;
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:int;
            _local_3 = _arg_1.length;
            if (_local_3 < 1)
            {
                return (0);
            };
            _local_5 = _arg_1[0];
            _local_6 = 1;
            while (_local_6 < _local_3)
            {
                _local_4 = _local_5;
                _local_5 = _arg_1[_local_6];
                _local_5 = _arg_2(_local_4, _local_5);
                _local_6++;
            };
            return (_local_5);
        }

        public static function and(_arg_1:Object, _arg_2:Object):Number
        {
            return (Number(((_arg_1) && (_arg_2))));
        }

        public static function pow(_arg_1:Number, _arg_2:Number):Number
        {
            if (_arg_1 < 0)
            {
                _arg_1 = -(_arg_1);
            };
            return (Math.pow(_arg_1, _arg_2));
        }

        public static function le(_arg_1:Object, _arg_2:Object):Number
        {
            return (Number((_arg_1 <= _arg_2)));
        }

        public static function neq(_arg_1:Object, _arg_2:Object):Number
        {
            return (Number((!(_arg_1 == _arg_2))));
        }

        public static function ge(_arg_1:Object, _arg_2:Object):Number
        {
            return (Number((_arg_1 >= _arg_2)));
        }

        public static function sum(_arg_1:Array):Number
        {
            return (calcGreedy(_arg_1, add));
        }


    }
}//package mb.expressions

