// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.expressions.Expression

package mb.expressions
{
    import mb.DataSource;

    public class Expression implements IExpression 
    {

        public static const INVALID:int = 9;
        public static const CASS:int = 1;
        public static const ASS:int = 2;
        public static const NUM_FIELD:int = 3;
        public static const STRING_FIELD:int = 4;
        public static const NUMBER:int = 5;
        public static const BIN_OP:int = 6;
        public static const GREEDY_OP:int = 7;
        public static const NULL:int = 8;
        public static const STRING:int = 15;
        private static const rxDelimStr:String = " ";
        private static const rxNullStr:String = "\\b(?P<nada>NULL)\\b";
        private static const rxGreedyOpStr:String = "(?P<greedy><[a-z]+>)";
        private static const rxBinOpStr:String = "(?P<bin>[+/*^\\-]|[><]=?|[!=]=|&&|\\|\\|)";
        private static const rxAssOpStr:String = "(?P<aop>\\??:)";
        private static const rxNumStr:String = "(?P<num>0[xX][a-fA-F0-9]{1,6}|-?\\d*\\.?\\d+)";
        private static const rxNameStr:String = "f'(?P<f2>[a-zA-Z_].*?)'|(?P<f1>[a-zA-Z_][a-zA-Z_0-9]*)";
        private static const rxStringStr:String = "(?P<quotes>'(?P<str>.*?)')";
        private static const rxTokenStr:String = ((((((((((((rxStringStr + "|") + rxNumStr) + "|") + rxGreedyOpStr) + "|") + rxBinOpStr) + "|") + rxAssOpStr) + "|") + rxNullStr) + "|") + rxNameStr);

        private var tokenArr:Array;
        private var _data:DataSource;
        private var _expression:String;
        private var _valid:Boolean = true;

        public function Expression(_arg_1:String, _arg_2:DataSource)
        {
            _expression = _arg_1;
            _data = _arg_2;
            _valid = compileExpression(_arg_1);
        }

        public function procRow(_arg_1:int):Object
        {
            var _local_2:Array;
            var _local_3:Object;
            var _local_4:Object;
            var _local_5:Number;
            var _local_6:MathObj;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_10:Object;
            var _local_11:Array;
            _local_2 = [1];
            _local_7 = 0;
            _local_8 = tokenArr.length;
            _local_9 = 0;
            while (_local_9 < _local_8)
            {
                _local_6 = MathObj(tokenArr[_local_9]);
                if (((_local_6.type == NUM_FIELD) || (_local_6.type == STRING_FIELD)))
                {
                    _local_3 = _local_6.arr[_arg_1];
                    _local_2.push(_local_3);
                }
                else
                {
                    if (_local_6.type == BIN_OP)
                    {
                        _local_4 = _local_2.pop();
                        _local_3 = _local_2.pop();
                        _local_5 = _local_6.func(_local_3, _local_4);
                        _local_2.push(_local_5);
                    }
                    else
                    {
                        if (_local_6.type == NULL)
                        {
                            _local_2.push(null);
                        }
                        else
                        {
                            if (_local_6.type == NUMBER)
                            {
                                _local_2.push(_local_6.value);
                            }
                            else
                            {
                                if (_local_6.type == STRING)
                                {
                                    _local_2.push(_local_6.string);
                                }
                                else
                                {
                                    if (_local_6.type == CASS)
                                    {
                                        _local_4 = _local_2.pop();
                                        _local_3 = _local_2.pop();
                                        if (_local_3)
                                        {
                                            _local_2.push(_local_4);
                                            break;
                                        };
                                    }
                                    else
                                    {
                                        if (_local_6.type == ASS) break;
                                        if (_local_6.type == GREEDY_OP)
                                        {
                                            _local_11 = [];
                                            while (_local_7 > 0)
                                            {
                                                _local_11.push(_local_2.pop());
                                                _local_7--;
                                            };
                                            _local_5 = _local_6.func(_local_11);
                                            _local_2.push(_local_5);
                                            if (_local_7 < 2)
                                            {
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
                if (((_local_6.type == NUMBER) || (_local_6.type == NUM_FIELD)))
                {
                    _local_7++;
                }
                else
                {
                    _local_7 = 0;
                };
                _local_9++;
            };
            _local_10 = _local_2.pop();
            return (_local_10);
        }

        public function compileExpression(_arg_1:String):Boolean
        {
            var _local_2:String;
            var _local_3:RegExp;
            var _local_4:Array;
            var _local_5:String;
            var _local_6:MathObj;
            var _local_7:String;
            if (!_data.ready)
            {
            };
            _local_2 = ((rxDelimStr + _arg_1) + rxDelimStr);
            _local_3 = new RegExp(rxTokenStr, "g");
            _valid = true;
            tokenArr = [];
            while ((_local_4 = _local_3.exec(_local_2)) != null)
            {
                _local_6 = new MathObj(INVALID);
                if (_local_4.nada)
                {
                    _local_6.type = NULL;
                }
                else
                {
                    if (_local_4.quotes)
                    {
                        _local_5 = _local_4.str;
                        _local_6.type = STRING;
                        _local_6.string = _local_5;
                    }
                    else
                    {
                        if (_local_4.bin)
                        {
                            _local_5 = _local_4.bin;
                            _local_6.type = BIN_OP;
                            switch (_local_5)
                            {
                                case "+":
                                    _local_6.func = Ops.add;
                                    break;
                                case "-":
                                    _local_6.func = Ops.sub;
                                    break;
                                case "*":
                                    _local_6.func = Ops.mul;
                                    break;
                                case "/":
                                    _local_6.func = Ops.div;
                                    break;
                                case "==":
                                    _local_6.func = Ops.eq;
                                    break;
                                case "!=":
                                    _local_6.func = Ops.neq;
                                    break;
                                case "<":
                                    _local_6.func = Ops.lt;
                                    break;
                                case "<=":
                                    _local_6.func = Ops.le;
                                    break;
                                case ">":
                                    _local_6.func = Ops.gt;
                                    break;
                                case ">=":
                                    _local_6.func = Ops.ge;
                                    break;
                                case "!=":
                                    _local_6.func = Ops.neq;
                                    break;
                                case "&&":
                                    _local_6.func = Ops.and;
                                    break;
                                case "||":
                                    _local_6.func = Ops.or;
                                    break;
                                case "^":
                                    _local_6.func = Ops.pow;
                                    break;
                                default:
                                    _local_6.type = INVALID;
                            };
                        }
                        else
                        {
                            if (_local_4.greedy)
                            {
                                _local_5 = _local_4.greedy;
                                _local_6.type = GREEDY_OP;
                                switch (_local_5)
                                {
                                    case "<sum>":
                                        _local_6.func = Ops.sum;
                                        break;
                                    case "<max>":
                                        _local_6.func = Ops.max;
                                        break;
                                    case "<min>":
                                        _local_6.func = Ops.min;
                                        break;
                                    case "<avg>":
                                        _local_6.func = Ops.avg;
                                        break;
                                    case "<rank>":
                                        _local_6.func = Ops.rank;
                                        break;
                                    default:
                                        _local_6.type = INVALID;
                                };
                            }
                            else
                            {
                                if (_local_4.aop)
                                {
                                    _local_5 = _local_4.aop;
                                    if (_local_5 == "?:")
                                    {
                                        _local_6.type = CASS;
                                    }
                                    else
                                    {
                                        if (_local_5 == ":")
                                        {
                                            _local_6.type = ASS;
                                        };
                                    };
                                }
                                else
                                {
                                    if (_local_4.num)
                                    {
                                        _local_5 = _local_4.num;
                                        _local_6.type = NUMBER;
                                        _local_6.value = Number(_local_5);
                                    }
                                    else
                                    {
                                        if (((_local_4.f1) || (_local_4.f2)))
                                        {
                                            _local_5 = ((_local_4.f1) ? _local_4.f1 : _local_4.f2);
                                            if (_data.fieldExists(_local_5))
                                            {
                                                _local_6.arr = _data.getFieldArray(_local_5);
                                                _local_7 = _data.getFieldType(_local_5);
                                                if (_local_7 == DataSource.STRING)
                                                {
                                                    _local_6.type = STRING_FIELD;
                                                }
                                                else
                                                {
                                                    if (((_local_7 == DataSource.INTEGER) || (_local_7 == DataSource.DOUBLE)))
                                                    {
                                                        _local_6.type = NUM_FIELD;
                                                    };
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
                if (_local_6.type != INVALID)
                {
                    tokenArr.push(_local_6);
                }
                else
                {
                    _valid = false;
                };
            };
            return (_valid);
        }

        public function get expression():String
        {
            return (_expression);
        }

        public function get valid():Boolean
        {
            return (_valid);
        }


    }
}//package mb.expressions

