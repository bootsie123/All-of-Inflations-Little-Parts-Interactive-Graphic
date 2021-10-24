// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.SuperTextField

package mb
{
    import flash.display.DisplayObjectContainer;
    import flash.text.TextFormat;
    import flash.text.TextField;
    import flash.filters.BitmapFilter;

    public class SuperTextField 
    {

        public static const LEFT:String = C.LEFT;
        public static const RIGHT:String = C.RIGHT;
        public static const CENTER:String = C.CENTER;

        protected var _container:DisplayObjectContainer;
        protected var fmt:TextFormat;
        protected var _text:String;
        protected var filters_arr:Array;
        protected var _upper:Boolean;
        protected var _prefix:String;
        protected var _width:Number;
        protected var txt:TextField;
        protected var _suffix:String;

        protected var _x:Number = 0;
        protected var _y:Number = 0;
        protected var _align:String = LEFT;

        public function SuperTextField(_arg_1:DisplayObjectContainer=null, _arg_2:String="")
        {
            _upper = false;
            fmt = new TextFormat();
            fmt.font = "Arial, Helvetica";
            fmt.size = 11;
            txt = Util.createTextField();
            if (_arg_1)
            {
                place(_arg_1);
            };
            txt.mouseEnabled = false;
            txt.defaultTextFormat = fmt;
            this.text = _arg_2;
        }

        public function get y():Number
        {
            return (_y);
        }

        public function get bold():Boolean
        {
            return (fmt.bold);
        }

        public function get size():uint
        {
            return (uint(fmt.size));
        }

        public function set size(_arg_1:uint):*
        {
            fmt.size = _arg_1;
            applyFormat();
        }

        public function set bold(_arg_1:Boolean):*
        {
            fmt.bold = _arg_1;
            applyFormat();
        }

        public function place(_arg_1:DisplayObjectContainer):*
        {
            _container = _arg_1;
            _container.addChild(txt);
            this.x = _x;
            this.y = _y;
        }

        public function set align(_arg_1:String):*
        {
            _align = _arg_1;
            alignText();
        }

        public function destroy():*
        {
            if (_container)
            {
                _container.removeChild(txt);
            };
        }

        public function get align():String
        {
            return (_align);
        }

        public function applyTemplate(_arg_1:SuperTextField):*
        {
            var _local_2:String;
            this.color = _arg_1.color;
            this.size = _arg_1.size;
            this.bold = _arg_1.bold;
            this.italic = _arg_1.italic;
            this.letter_spacing = _arg_1.letter_spacing;
            this.upper = _arg_1.upper;
            if (_arg_1.multiline)
            {
                this.multiline = _arg_1.multiline;
                this.width = _arg_1.width;
            };
            if (_suffix)
            {
                _local_2 = _suffix;
                _suffix = "";
                this.text = _text;
                this.align = _arg_1.align;
                suffix = _local_2;
            }
            else
            {
                this.align = _arg_1.align;
            };
        }

        public function set width(_arg_1:Number):*
        {
            txt.width = _arg_1;
        }

        public function get field():TextField
        {
            return (txt);
        }

        public function set font(_arg_1:String):*
        {
            fmt.font = _arg_1;
            applyFormat();
        }

        public function set y(_arg_1:Number):*
        {
            _y = _arg_1;
            if (_container)
            {
                txt.y = _arg_1;
            };
        }

        public function get upper():Boolean
        {
            return (_upper);
        }

        public function addFilter(_arg_1:BitmapFilter):*
        {
            if (!filters_arr)
            {
                filters_arr = [];
            };
            filters_arr.push(_arg_1);
            txt.filters = filters_arr;
        }

        public function applyFormat():*
        {
            txt.setTextFormat(fmt);
            txt.defaultTextFormat = fmt;
        }

        public function set suffix(_arg_1:String):*
        {
            _suffix = _arg_1;
            applySuffix();
        }

        public function get letter_spacing():uint
        {
            return (uint(fmt.letterSpacing));
        }

        public function get visible():Boolean
        {
            return (txt.visible);
        }

        public function get text():String
        {
            return (txt.text);
        }

        public function get height():Number
        {
            return (txt.height);
        }

        public function get italic():Boolean
        {
            return (fmt.italic);
        }

        public function get multiline():Boolean
        {
            return (txt.multiline);
        }

        public function set upper(_arg_1:Boolean):*
        {
            _upper = _arg_1;
            if (((!(_text)) || (_text == "undefined")))
            {
                return;
            };
            if (_upper)
            {
                txt.text = txt.text.toUpperCase();
            }
            else
            {
                text = _text;
            };
        }

        public function set color(_arg_1:uint):*
        {
            fmt.color = _arg_1;
            applyFormat();
        }

        public function get suffix():String
        {
            return (_suffix);
        }

        protected function alignText():*
        {
            var _local_1:Number;
            if (!_container)
            {
                return;
            };
            if (txt.multiline)
            {
                applyMultilineAlign();
            };
            if (_align == CENTER)
            {
                _local_1 = Math.round((txt.width / 2));
                txt.x = (-(_local_1) + _x);
            }
            else
            {
                if (_align == RIGHT)
                {
                    txt.x = (_x - txt.width);
                }
                else
                {
                    txt.x = _x;
                };
            };
        }

        public function set letter_spacing(_arg_1:uint):*
        {
            fmt.letterSpacing = _arg_1;
            applyFormat();
        }

        public function set alignment(_arg_1:String):*
        {
            this.align = _arg_1;
        }

        public function set text(_arg_1:String):*
        {
            if (_arg_1 === null)
            {
                return;
            };
            _text = _arg_1;
            if (_suffix)
            {
                txt.text = (_arg_1 + _suffix);
            }
            else
            {
                txt.text = _arg_1;
            };
            if (_upper)
            {
                txt.text = txt.text.toUpperCase();
            };
            if (_align != LEFT)
            {
                x = _x;
            };
            if (_suffix)
            {
                applySuffix();
            };
        }

        public function clone():SuperTextField
        {
            var _local_1:SuperTextField;
            _local_1 = new SuperTextField();
            _local_1.applyTemplate(this);
            return (_local_1);
        }

        public function get width():Number
        {
            return (txt.width);
        }

        public function applySuffix():*
        {
            var _local_1:String;
            if (((_suffix) && (_text)))
            {
                _local_1 = _suffix;
                if (this.upper)
                {
                    _local_1 = _local_1.toUpperCase();
                };
                txt.text = (_text + _local_1);
            };
        }

        public function set multiline(_arg_1:Boolean):*
        {
            txt.multiline = _arg_1;
            txt.wordWrap = true;
            applyMultilineAlign();
        }

        public function get color():uint
        {
            return (uint(fmt.color));
        }

        public function set visible(_arg_1:Boolean):*
        {
            txt.visible = _arg_1;
        }

        private function applyMultilineAlign():*
        {
            if (txt.multiline)
            {
                if (_align == C.CENTER)
                {
                    fmt.align = "center";
                    applyFormat();
                };
            };
        }

        public function set format(_arg_1:TextFormat):*
        {
            this.fmt = _arg_1;
            applyFormat();
        }

        public function set italic(_arg_1:Boolean):*
        {
            fmt.italic = _arg_1;
            applyFormat();
        }

        public function get x():Number
        {
            return (_x);
        }

        public function get filters():Array
        {
            return (filters_arr);
        }

        public function set x(_arg_1:Number):*
        {
            _x = _arg_1;
            if (_container)
            {
                alignText();
            };
        }


    }
}//package mb

