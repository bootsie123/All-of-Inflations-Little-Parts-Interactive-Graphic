// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.ColorScheme

package mb
{
    import mb.expressions.IExpression;
    import flash.display.DisplayObject;
    import flash.filters.BitmapFilter;

    public class ColorScheme 
    {

        protected var _data:DataSource;
        protected var _fillField:String;
        protected var _fillExp:IExpression;
        protected var filtersArr:Array;

        protected var _fillColor:uint = 0xEEEEEE;
        protected var _fillAlpha:Number = 1;
        protected var _strokeColor:uint = 0;
        protected var _strokeWeight:int = 0;
        protected var _strokeAlpha:Number = 1;
        protected var _haveStroke:Boolean = false;
        protected var _haveFill:Boolean = false;
        protected var _haveFilters:Boolean = false;
        protected var _rid:int = -1;

        public function ColorScheme(_arg_1:DataSource=null)
        {
            _data = _arg_1;
            filtersArr = [];
        }

        public function get fillExpression():IExpression
        {
            return (_fillExp);
        }

        public function setFill(_arg_1:uint, _arg_2:Number=1):*
        {
            _fillColor = _arg_1;
            _fillAlpha = _arg_2;
            _haveFill = true;
        }

        public function get strokeAlpha():Number
        {
            return (_strokeAlpha);
        }

        public function get strokeColor():uint
        {
            return (_strokeColor);
        }

        public function init(_arg_1:ColorScheme):*
        {
            if (haveFill)
            {
                _arg_1.setFill(_fillColor, _fillAlpha);
            };
            if (haveStroke)
            {
                _arg_1.setStroke(_strokeWeight, _strokeColor, _strokeAlpha);
            };
            _arg_1.fillField = _fillField;
        }

        public function set rid(_arg_1:int):*
        {
            _rid = _arg_1;
        }

        public function get fillAlpha():Number
        {
            if (!_haveFill)
            {
                return (0);
            };
            return (_fillAlpha);
        }

        public function get fillColor():uint
        {
            if (_rid != -1)
            {
                if (((_fillField) && (_data)))
                {
                    return (_data.getNumber(_rid, _fillField));
                };
                if (_fillExp)
                {
                    return (uint(_fillExp.procRow(_rid)));
                };
            };
            return (_fillColor);
        }

        public function get haveFill():Boolean
        {
            return (_haveFill);
        }

        public function get hasFillExpression():Boolean
        {
            return ((_fillExp) ? true : false);
        }

        public function setStroke(_arg_1:int, _arg_2:uint=0, _arg_3:Number=1):*
        {
            _strokeColor = _arg_2;
            _strokeWeight = _arg_1;
            _strokeAlpha = _arg_3;
            _haveStroke = ((_arg_1 > 0) ? true : false);
        }

        public function applyFilters(_arg_1:DisplayObject):*
        {
            if (this.haveFilters)
            {
                _arg_1.filters = filtersArr;
            };
        }

        public function get haveStroke():Boolean
        {
            return (_haveStroke);
        }

        public function get strokeWeight():int
        {
            return (_strokeWeight);
        }

        public function set data(_arg_1:DataSource):*
        {
            _data = _arg_1;
        }

        public function clearStroke():*
        {
            _strokeWeight = 0;
            _haveStroke = false;
        }

        public function set fillField(_arg_1:String):*
        {
            _fillField = _arg_1;
            _haveFill = true;
        }

        public function get haveFilters():Boolean
        {
            return (_haveFilters);
        }

        public function set fillExpression(_arg_1:IExpression):*
        {
            _fillExp = _arg_1;
            _haveFill = ((_fillExp) ? true : false);
        }

        public function clearFill():*
        {
            _haveFill = false;
        }

        public function addFilter(_arg_1:BitmapFilter):*
        {
            if (!filtersArr)
            {
                filtersArr = [];
            };
            filtersArr.push(_arg_1);
            _haveFilters = true;
        }

        public function get filters():Array
        {
            return (filtersArr);
        }


    }
}//package mb

