// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.MouseService

package mb
{
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Point;

    public class MouseService extends Notifier 
    {

        public static const ROLL_OUT:String = C.ROLL_OUT;//"roll_out"
        public static const ROLL_OVER:String = C.ROLL_OVER;//"roll_over"
        public static const MOUSE_DOWN:String = C.MOUSE_DOWN;//"down"
        public static const MOUSE_MOVE:String = C.MOUSE_MOVE;//"move"
        public static const MOUSE_UP:String = C.MOUSE_UP;//"up"
        public static const CLICK:String = C.CLICK;//"click"
        public static const PRESS:String = C.PRESS;//"press"
        public static const DBL_CLICK:String = C.DBL_CLICK;//"dbl_click"
        public static const MOUSE_DRAG:String = C.MOUSE_DRAG;//"drag"

        private var _screen:Sprite;
        private var lastDownTime:Number;
        private var xLastDown:Number;
        private var yLastDown:Number;

        private var _buttonDown:Boolean = false;
        private var _mouseOverMap:Boolean = false;
        private var xDown:Number = 0;
        private var yDown:Number = 0;
        private var downTime:Number = 0;
        private var xLastMove:Number = 0;
        private var yLastMove:Number = 0;
        private var hitRadius:Number = 4;
        private var clickTimeout:Number = 300;
        private var dblClickTimeout:Number = 500;

        public function MouseService(_arg_1:Sprite)
        {
            _screen = _arg_1;
            _arg_1.addEventListener(MouseEvent.MOUSE_OVER, handleMouseOver);
            _arg_1.addEventListener(MouseEvent.MOUSE_OUT, handleMouseOut);
            _arg_1.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
            _arg_1.stage.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
            _arg_1.stage.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
        }

        public function set enabled(_arg_1:Boolean):*
        {
            var _local_2:Boolean;
            _screen.mouseEnabled = _arg_1;
            _local_2 = _screen.hasEventListener(MouseEvent.MOUSE_UP);
            if (((_arg_1) && (!(_local_2))))
            {
                _screen.stage.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
                _screen.stage.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
            };
            if (((!(_arg_1)) && (_local_2)))
            {
                _screen.stage.removeEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
                _screen.stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
            };
        }

        public function set useHandCursor(_arg_1:Boolean):*
        {
            if (_arg_1)
            {
                _screen.buttonMode = true;
                _screen.useHandCursor = true;
            }
            else
            {
                _screen.buttonMode = false;
                _screen.useHandCursor = false;
            };
        }

        private function handleMouseOut(_arg_1:Object):*
        {
            if (_mouseOverMap == false)
            {
                return;
            };
            _mouseOverMap = false;
            notify(null, ROLL_OUT);
        }

        private function handleMouseDown(_arg_1:Object):*
        {
            xLastDown = xDown;
            yLastDown = yDown;
            lastDownTime = downTime;
            _buttonDown = true;
            xDown = _screen.mouseX;
            yDown = _screen.mouseY;
            downTime = new Date().getTime();
            notify({"data":new PixelPoint(xDown, yDown, _screen)}, MOUSE_DOWN);
            if (this.overScreen)
            {
                notify({"data":new PixelPoint(xDown, yDown, _screen)}, PRESS);
            };
        }

        private function handleMouseOver(_arg_1:Object):*
        {
            if (_buttonDown)
            {
            };
            _mouseOverMap = true;
            notify(null, ROLL_OVER);
        }

        private function handleMouseMove(_arg_1:Object):*
        {
            var _local_2:PixelPoint;
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Point;
            _local_2 = this.pos;
            if (Math.abs((_local_2.x - xLastMove)) < 1)
            {
                if (Math.abs((_local_2.y - yLastMove)) < 1)
                {
                    return;
                };
            };
            notify({"data":_local_2}, MOUSE_MOVE);
            if (_buttonDown)
            {
                _local_3 = (_local_2.x - xLastMove);
                _local_4 = (_local_2.y - yLastMove);
                _local_5 = new Point(_local_3, _local_4);
                notify({"data":_local_5}, MOUSE_DRAG);
            };
            xLastMove = _local_2.x;
            yLastMove = _local_2.y;
        }

        private function handleMouseUp(_arg_1:Object):*
        {
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:PixelPoint;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:Number;
            _local_2 = _screen.mouseX;
            _local_3 = _screen.mouseY;
            _local_4 = new Date().getTime();
            _buttonDown = false;
            _local_5 = this.pos;
            notify({"data":_local_5}, MOUSE_UP);
            if (this.overScreen)
            {
                if ((_local_4 - downTime) <= clickTimeout)
                {
                    _local_6 = Math.abs((_local_2 - xDown));
                    _local_7 = Math.abs((_local_3 - yDown));
                    if (((_local_6 <= hitRadius) && (_local_7 <= hitRadius)))
                    {
                        if ((_local_4 - lastDownTime) <= dblClickTimeout)
                        {
                            _local_8 = Math.abs((_local_2 - xLastDown));
                            _local_9 = Math.abs((_local_3 - yLastDown));
                            if (((_local_8 <= hitRadius) && (_local_9 <= hitRadius)))
                            {
                                notify({"data":_local_5}, DBL_CLICK);
                            };
                        }
                        else
                        {
                            notify({"data":_local_5}, CLICK);
                        };
                    };
                };
            };
        }

        public function get pos():PixelPoint
        {
            var _local_1:PixelPoint;
            return (new PixelPoint(_screen.mouseX, _screen.mouseY, _screen));
        }

        public function get overScreen():Boolean
        {
            var _local_1:PixelPoint;
            var _local_2:PixelPoint;
            _local_1 = this.pos;
            _local_2 = _local_1.copyToLocal(_screen.stage);
            return (_screen.hitTestPoint(_local_2.x, _local_2.y));
        }

        public function get overMap():Boolean
        {
            return (_mouseOverMap);
        }

        public function get buttonDown():Boolean
        {
            return (_buttonDown);
        }


    }
}//package mb

