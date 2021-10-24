// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.zooming.ZoomTool

package mb.zooming
{
    import mb.Notifier;
    import mb.MapStack;
    import flash.display.MovieClip;
    import flash.events.MouseEvent;

    public class ZoomTool extends Notifier 
    {

        private var map:MapStack;
        private var lat:Number;
        private var out_mc:MovieClip;
        private var in_mc:MovieClip;
        private var long:Number;

        public function ZoomTool(_arg_1:MovieClip, _arg_2:MovieClip, _arg_3:MapStack)
        {
            this.map = _arg_3;
            this.in_mc = _arg_1;
            this.out_mc = _arg_2;
            _arg_1.buttonMode = true;
            _arg_1.useHandCursor = true;
            _arg_2.buttonMode = true;
            _arg_2.useHandCursor = true;
            _arg_3.setCallback(this, init, Notifier.READY);
        }

        private function init(_arg_1:Object):*
        {
            in_mc.addEventListener(MouseEvent.MOUSE_DOWN, handleZoomIn);
            out_mc.addEventListener(MouseEvent.MOUSE_DOWN, handleZoomOut);
        }

        private function handleZoomIn(_arg_1:MouseEvent):*
        {
            map.navigation.zoomIn();
        }

        private function handleMapZoom(_arg_1:Object):*
        {
        }

        public function handleZoomOut(_arg_1:MouseEvent):*
        {
            map.navigation.zoomOut();
        }


    }
}//package mb.zooming

