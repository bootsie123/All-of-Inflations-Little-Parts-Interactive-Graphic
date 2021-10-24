// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.ImageLayer

package mb
{
    import flash.display.MovieClip;

    public class ImageLayer extends MapLayer 
    {

        private var _y:Number;
        private var _baseScale:Number;
        private var _mc:MovieClip;
        private var _x:Number;

        public function ImageLayer(_arg_1:MovieClip)
        {
            _mc = _arg_1;
            _arg_1.visible = false;
            _mc.mouseEnabled = false;
            _baseScale = _mc.scaleX;
            _layerType = IMAGE;
            _layerFamily = IMAGE;
        }

        private function adjustVisibility():*
        {
            var _local_1:Number;
            var _local_2:Boolean;
            var _local_3:Number;
            _local_1 = _map.navigation.scale;
            _local_2 = _mc.visible;
            if (((testScale(_local_1)) && (!(_local_2))))
            {
                _mc.visible = true;
                _local_3 = (_baseScale * _local_1);
                _mc.scaleX = (_mc.scaleY = _local_3);
                _mc.x = (_x * _local_1);
                _mc.y = (_y * _local_1);
            }
            else
            {
                if (((!(testScale(_local_1))) && (_local_2)))
                {
                    _mc.visible = false;
                };
            };
        }

        private function handleRescale(_arg_1:Object):*
        {
            adjustVisibility();
        }

        override protected function handleReadyState():*
        {
            container_mc.addChild(_mc);
            _x = _mc.x;
            _y = _mc.y;
            _map.navigation.setCallback(this, handleRescale, NavigationManager.RESCALE);
            adjustVisibility();
        }


    }
}//package mb

