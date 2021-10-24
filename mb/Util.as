// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.Util

package mb
{
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Point;
    import flash.display.Sprite;
    import flash.utils.getDefinitionByName;
    import flash.geom.ColorTransform;

    public class Util 
    {


        public static function createTextField(_arg_1:DisplayObjectContainer=null):TextField
        {
            var _local_2:TextField;
            _local_2 = new TextField();
            if (_arg_1)
            {
                _arg_1.addChild(_local_2);
            };
            _local_2.autoSize = TextFieldAutoSize.LEFT;
            _local_2.selectable = false;
            return (_local_2);
        }

        public static function getMonthString(_arg_1:Date):String
        {
            var _local_2:Array;
            _local_2 = ["Jan.", "Feb.", "March", "April", "May", "June", "July", "Aug.", "Sept.", "Oct.", "Nov.", "Dec."];
            return (_local_2[_arg_1.getMonth()]);
        }

        public static function localToLocal(_arg_1:Point, _arg_2:DisplayObjectContainer, _arg_3:DisplayObjectContainer):Point
        {
            _arg_1 = _arg_2.localToGlobal(_arg_1);
            return (_arg_3.globalToLocal(_arg_1));
        }

        public static function createSprite(_arg_1:DisplayObjectContainer):Sprite
        {
            var _local_2:Sprite;
            _local_2 = new Sprite();
            _arg_1.addChild(_local_2);
            return (_local_2);
        }

        public static function formatValue(_arg_1:Number, _arg_2:Number=0):String
        {
            var _local_3:String;
            var _local_4:String;
            var _local_5:Number;
            var _local_6:String;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:String;
            if (isNaN(_arg_1))
            {
                return ("");
            };
            if (isNaN(_arg_2))
            {
                _arg_2 = 0;
            };
            _local_3 = "";
            _local_4 = "";
            _local_5 = 0;
            if (_arg_2 > 0)
            {
                _local_7 = Math.pow(10, _arg_2);
                _local_8 = 1E-7;
                _local_5 = Math.round(((Math.abs(_arg_1) * _local_7) + _local_8));
                _local_3 = String(Math.floor((_local_5 / _local_7)));
                _local_4 = String((_local_5 % _local_7));
                while (_local_4.length < _arg_2)
                {
                    _local_4 = ("0" + _local_4);
                };
                _local_4 = ("." + _local_4);
            }
            else
            {
                _local_5 = Math.round(Math.abs(_arg_1));
                _local_3 = String(_local_5);
            };
            _local_6 = (((_arg_1 < 0) && (_local_5 > 0)) ? "-" : "");
            if (_local_3.length > 3)
            {
                _local_9 = _local_3.length;
                _local_10 = "";
                while (_local_9 > 3)
                {
                    _local_10 = (("," + _local_3.substr((_local_9 - 3), 3)) + _local_10);
                    _local_9 = (_local_9 - 3);
                };
                _local_3 = (_local_3.substr(0, _local_9) + _local_10);
            };
            return ((_local_6 + _local_3) + _local_4);
        }

        public static function strToDate(_arg_1:String):Date
        {
            var _local_2:Number;
            var _local_3:Array;
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:Date;
            _local_2 = _arg_1.indexOf(" ");
            if (_local_2 != -1)
            {
                _arg_1 = _arg_1.substring(0, _local_2);
            };
            if (_arg_1 == "")
            {
                return (null);
            };
            _local_3 = _arg_1.split("/");
            _local_4 = Number(_local_3[2]);
            _local_5 = (Number(_local_3[1]) - 1);
            _local_6 = Number(_local_3[0]);
            if ((((isNaN(_local_6)) || (isNaN(_local_5))) || (isNaN(_local_4))))
            {
                return (null);
            };
            _local_7 = new Date(_local_6, _local_5, _local_4);
            return (_local_7);
        }

        public static function attachLibrarySprite(_arg_1:String, _arg_2:DisplayObjectContainer):Sprite
        {
            var _local_3:Class;
            var _local_4:Sprite;
            _local_3 = (getDefinitionByName(_arg_1) as Class);
            _local_4 = (new (_local_3)() as Sprite);
            if (!_local_4)
            {
                _arg_2.root.visible = false;
            };
            _arg_2.addChild(_local_4);
            return (_local_4);
        }

        public static function setSpriteColor(_arg_1:Sprite, _arg_2:Number, _arg_3:Number=NaN):*
        {
            var _local_4:ColorTransform;
            _local_4 = new ColorTransform();
            if (!isNaN(_arg_3))
            {
                _local_4.alphaMultiplier = _arg_3;
            };
            _local_4.color = _arg_2;
            _arg_1.transform.colorTransform = _local_4;
        }

        public static function drawRectangle(_arg_1:Sprite, _arg_2:ColorScheme, _arg_3:Number, _arg_4:Number, _arg_5:Number=0, _arg_6:Number=0):*
        {
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:Number;
            if (!_arg_2)
            {
                _arg_2 = new ColorScheme();
                _arg_2.setFill(14673125, 0);
            };
            _local_7 = _arg_5;
            _local_8 = _arg_6;
            _local_9 = (_arg_3 + _arg_5);
            _local_10 = (_arg_4 + _arg_6);
            if (_arg_2.strokeWeight)
            {
                _arg_1.graphics.lineStyle(_arg_2.strokeWeight, _arg_2.strokeColor);
            };
            if (_arg_2.haveFill)
            {
                _arg_1.graphics.beginFill(_arg_2.fillColor, _arg_2.fillAlpha);
            };
            _arg_1.graphics.moveTo(_local_7, _local_8);
            _arg_1.graphics.lineTo(_local_7, _local_10);
            _arg_1.graphics.lineTo(_local_9, _local_10);
            _arg_1.graphics.lineTo(_local_9, _local_8);
            _arg_1.graphics.lineTo(_local_7, _local_8);
            if (_arg_2.haveFill)
            {
                _arg_1.graphics.endFill();
            };
        }

        public static function drawMatchingRectangle(_arg_1:Sprite, _arg_2:Sprite, _arg_3:ColorScheme=null):*
        {
            var _local_4:Point;
            var _local_5:Point;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:Number;
            if (_arg_3 == null)
            {
                _arg_3 = new ColorScheme();
                _arg_3.setFill(0, 0);
                _arg_3.setStroke(0, 0);
            };
            _local_4 = new Point(_arg_2.x, _arg_2.y);
            _local_5 = new Point((_arg_2.x + _arg_2.width), (_arg_2.y + _arg_2.height));
            _local_4 = localToLocal(_local_4, _arg_2.parent, _arg_1);
            _local_5 = localToLocal(_local_5, _arg_2.parent, _arg_1);
            _local_6 = _local_4.x;
            _local_7 = _local_4.y;
            _local_8 = _local_5.x;
            _local_9 = _local_5.y;
            drawRectangle(_arg_1, _arg_3, (_local_8 - _local_6), (_local_9 - _local_7), _local_6, _local_7);
        }

        public static function strip(_arg_1:String, _arg_2:String):String
        {
            if (_arg_2.length != 1)
            {
                return (_arg_1);
            };
            while (_arg_1.indexOf(_arg_2) == 0)
            {
                _arg_1 = _arg_1.substring(1);
            };
            while (_arg_1.charAt((_arg_1.length - 1)) === _arg_2)
            {
                _arg_1 = _arg_1.slice(0, -1);
            };
            return (_arg_1);
        }


    }
}//package mb

