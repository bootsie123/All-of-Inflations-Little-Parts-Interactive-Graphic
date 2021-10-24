// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.MapMain

package mb
{
    import flash.display.MovieClip;
    import flash.display.DisplayObjectContainer;
    import flash.display.StageScaleMode;

    public class MapMain extends Waiter 
    {

        protected var _align:MovieClip;
        protected var _root:DisplayObjectContainer;

        public function MapMain(_arg_1:MovieClip)
        {
            _root = DisplayObjectContainer(_arg_1.root);
            _align = _arg_1;
            _arg_1.stage.scaleMode = StageScaleMode.NO_SCALE;
        }

    }
}//package mb

