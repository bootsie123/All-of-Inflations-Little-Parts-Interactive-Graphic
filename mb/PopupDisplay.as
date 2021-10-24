// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.PopupDisplay

package mb
{
    import flash.display.Sprite;
    import flash.display.DisplayObjectContainer;
    import flash.filters.DropShadowFilter;
    import flash.display.*;
    import flash.text.*;

    public class PopupDisplay 
    {

        internal var tail_txt:SuperTextField;
        internal var title_txt:SuperTextField;
        internal var container_mc:Sprite;
        internal var content_mc:Sprite;
        internal var mouse:MouseService;
        internal var _style:ColorScheme;
        internal var _root:DisplayObjectContainer;
        internal var subtitle_txt:SuperTextField;
        internal var bg_mc:Sprite;
        internal var rowsObj:Object;

        private var yPos:Number = 0;
        internal var xCol2Right:Number = 140;
        internal var rowHeight:Number = 16;
        internal var textHeight:Number = 12;
        internal var titleHeight:Number = 14;
        internal var lineSpacing:Number = 2;
        internal var padding:Number = 4;
        internal var xOffsetBottom:Number = -40;
        internal var yOffsetBottom:Number = 26;
        internal var xOffsetRight:Number = 15;
        internal var yOffsetRight:Number = -20;
        internal var yOffset:Number = yOffsetBottom;
        internal var xOffset:Number = xOffsetBottom;
        internal var yFlipThreshold:Number = 1000;
        internal var yFlipOffset:Number = 46;
        internal var placement:String = "s";

        public function PopupDisplay(_arg_1:DisplayObjectContainer, _arg_2:MouseService)
        {
            rowsObj = {};
            this._root = _arg_1;
            this.mouse = _arg_2;
            container_mc = Util.createSprite(_root);
            bg_mc = Util.createSprite(container_mc);
            content_mc = Util.createSprite(container_mc);
            title_txt = new SuperTextField(content_mc);
            title_txt.size = titleHeight;
            content_mc.x = padding;
            content_mc.y = padding;
            title_txt.text = ".";
            hide();
            _arg_2.setCallback(this, setPosition, MouseService.MOUSE_MOVE);
            _style = new ColorScheme();
            _style.setStroke(1, 0xCCCCCC);
            _style.setFill(0xFFFFFF, 0.8);
        }

        private function clearTable():*
        {
            var _local_1:String;
            for (_local_1 in rowsObj)
            {
                rowsObj[_local_1].c1.text = "";
                rowsObj[_local_1].c2.text = "";
            };
        }

        private function updatePosition(_arg_1:Number, _arg_2:Number):*
        {
            if (container_mc.visible)
            {
                container_mc.x = (container_mc.x + _arg_1);
                container_mc.y = (container_mc.y + _arg_2);
            };
        }

        private function setPosition(_arg_1:Object=null):*
        {
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:Number;
            var _local_11:Number;
            var _local_12:Number;
            _local_2 = _root.mouseX;
            _local_3 = _root.mouseY;
            if (placement == "s")
            {
                _local_4 = xOffsetBottom;
                _local_5 = yOffsetBottom;
            }
            else
            {
                _local_4 = xOffsetRight;
                _local_5 = yOffsetRight;
            };
            _local_6 = (((container_mc.stage.stageHeight - _local_3) - _local_5) - container_mc.height);
            if (((_local_6 < 0) || (_local_3 > yFlipThreshold)))
            {
                if (((_local_6 < 0) && (_local_3 < yFlipThreshold)))
                {
                    yFlipThreshold = _local_3;
                };
                _local_5 = (_local_5 - (container_mc.height + yFlipOffset));
            };
            _local_7 = Math.abs((container_mc.x - (_local_2 + _local_4)));
            if (_local_7 < 1)
            {
                _local_12 = Math.abs((container_mc.y - (_local_3 + _local_5)));
                if (_local_12 < 1)
                {
                    return;
                };
            };
            container_mc.x = (_local_2 + _local_4);
            container_mc.y = (_local_3 + _local_5);
            _local_8 = 4;
            _local_9 = (container_mc.stage.stageWidth - (container_mc.x + container_mc.width));
            if (_local_9 < _local_8)
            {
                container_mc.x = (container_mc.x - (_local_8 - _local_9));
            };
            _local_10 = 4;
            _local_11 = container_mc.x;
            if (_local_11 < _local_10)
            {
                container_mc.x = _local_10;
            };
        }

        private function displayRow(_arg_1:Number, _arg_2:Number, _arg_3:String, _arg_4:String):*
        {
            var _local_5:SuperTextField;
            var _local_6:SuperTextField;
            var _local_7:Object;
            if (!rowsObj[_arg_1])
            {
                _local_7 = (rowsObj[_arg_1] = {});
                _local_5 = (_local_7.c1 = new SuperTextField(content_mc));
                _local_6 = (_local_7.c2 = new SuperTextField(content_mc));
                _local_6.align = SuperTextField.RIGHT;
            }
            else
            {
                _local_7 = rowsObj[_arg_1];
                _local_5 = _local_7.c1;
                _local_6 = _local_7.c2;
            };
            _local_6.x = xCol2Right;
            _local_5.y = _arg_2;
            _local_6.y = _arg_2;
            if (_arg_1 == 1)
            {
            };
            _local_5.text = _arg_3;
            _local_6.text = _arg_4;
        }

        public function set minWidth(_arg_1:Number):*
        {
            xCol2Right = _arg_1;
        }

        public function get visible():Boolean
        {
            return (container_mc.visible);
        }

        public function clear():*
        {
            var _local_1:String;
            var _local_2:Object;
            for (_local_1 in rowsObj)
            {
                _local_2 = rowsObj[_local_1];
                _local_2.c1.destroy();
                _local_2.c2.destroy();
            };
            rowsObj = {};
        }

        private function initPosition():*
        {
            placement = "s";
        }

        public function display(_arg_1:String, _arg_2:Array, _arg_3:String=null, _arg_4:String=null):*
        {
            clearTable();
            addText(_arg_1, _arg_2, _arg_3, _arg_4);
            container_mc.visible = true;
            initPosition();
            setPosition();
        }

        public function hide():*
        {
            container_mc.visible = false;
        }

        public function addText(_arg_1:String, _arg_2:Array, _arg_3:String=null, _arg_4:String=null):*
        {
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:Number;
            var _local_11:Number;
            var _local_12:Number;
            var _local_13:Number;
            var _local_14:Number;
            var _local_15:DropShadowFilter;
            var _local_16:Object;
            var _local_17:String;
            var _local_18:int;
            var _local_19:int;
            var _local_20:String;
            var _local_21:String;
            yPos = 0;
            title_txt.text = _arg_1;
            _local_5 = title_txt.height;
            _local_6 = title_txt.width;
            _local_7 = _local_6;
            yPos = (yPos + (_local_5 - 1));
            if (_arg_3)
            {
                if (!subtitle_txt)
                {
                    subtitle_txt = new SuperTextField(content_mc);
                    subtitle_txt.italic = true;
                }
                else
                {
                    subtitle_txt.visible = true;
                };
                subtitle_txt.y = yPos;
                subtitle_txt.text = _arg_3;
                if (subtitle_txt.width > _local_7)
                {
                    _local_7 = subtitle_txt.width;
                };
                yPos = (yPos + rowHeight);
            }
            else
            {
                if (subtitle_txt)
                {
                    subtitle_txt.visible = false;
                };
            };
            if (_arg_2)
            {
                _local_17 = "";
                _local_18 = _arg_2.length;
                _local_19 = 0;
                while (_local_19 < _local_18)
                {
                    _local_16 = _arg_2[_local_19];
                    _local_20 = _local_16[0];
                    _local_21 = _local_16[1];
                    displayRow((_local_19 + 1), yPos, _local_20, _local_21);
                    yPos = (yPos + rowHeight);
                    _local_19++;
                };
            };
            _local_8 = xCol2Right;
            if (_local_8 > _local_7)
            {
                _local_7 = _local_8;
            };
            if (content_mc.width > _local_7)
            {
                _local_7 = content_mc.width;
            };
            if (_arg_4)
            {
                if (!tail_txt)
                {
                    tail_txt = new SuperTextField(content_mc, _arg_4);
                    tail_txt.italic = true;
                    tail_txt.multiline = true;
                };
                tail_txt.y = (yPos + 1);
                tail_txt.width = _local_7;
            }
            else
            {
                if (tail_txt)
                {
                    tail_txt.destroy();
                    tail_txt = null;
                };
            };
            _local_9 = content_mc.height;
            _local_10 = _local_9;
            _local_11 = 0;
            _local_12 = 0;
            _local_13 = (_local_7 + (2 * padding));
            _local_14 = ((2 * padding) + _local_10);
            bg_mc.graphics.clear();
            Util.drawRectangle(bg_mc, _style, (_local_13 - _local_11), (_local_14 - _local_12), _local_11, _local_12);
            _local_15 = new DropShadowFilter(3, 45, 0, 0.2, 10, 10, 1, 1);
            bg_mc.filters = [_local_15];
        }


    }
}//package mb

