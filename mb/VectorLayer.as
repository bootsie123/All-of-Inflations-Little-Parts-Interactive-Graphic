// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.VectorLayer

package mb
{
    import mb.symbols.ISymbolManager;
    import mb.expressions.IFilter;
    import flash.display.Sprite;

    public class VectorLayer extends MapLayer 
    {

        protected var _symbolManager:ISymbolManager;
        protected var _data:DataSource;
        protected var _view:DataView;
        protected var _filter:IFilter;
        protected var _rendered:Boolean = false;
        protected var canvas_mc:Sprite;

        public function VectorLayer(_arg_1:DataSource)
        {
            if (_arg_1 !== null)
            {
                _data = _arg_1;
                _view = new DataView(_arg_1);
                addDependency(_arg_1);
            };
            _layerType = VECTOR;
            _layerFamily = VECTOR;
            canvas_mc = Util.createSprite(container_mc);
        }

        public function get view():DataView
        {
            return (_view);
        }

        public function get data():DataSource
        {
            return (_data);
        }

        public function refresh():Boolean
        {
            return (true);
        }

        public function set filter(_arg_1:IFilter):*
        {
            _filter = _arg_1;
            if (_symbolManager)
            {
                _symbolManager.setFilter(_arg_1);
            };
        }

        override public function destroy():*
        {
            if (_data)
            {
                if (!_data.ready)
                {
                    _data.unsetCallback(this, Notifier.READY);
                };
                _data = null;
            };
            canvas_mc.graphics.clear();
            super.destroy();
        }


    }
}//package mb

