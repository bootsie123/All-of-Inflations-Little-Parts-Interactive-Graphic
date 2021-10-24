// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.LabelStyle

package mb
{
    import flash.display.Sprite;

    public class LabelStyle extends PointStyle 
    {

        private var _placementField:String;
        private var _textField:String;
        private var _template:LabelField;
        private var _placement:String = C.N;//"n"

        public function LabelStyle(_arg_1:DataSource)
        {
            super(_arg_1);
        }

        public function set template(_arg_1:LabelField):*
        {
            _template = _arg_1;
        }

        public function updateLabelField(_arg_1:LabelField):*
        {
            var _local_2:String;
            if (_template)
            {
                _arg_1.init(_template);
            };
            if (_textField)
            {
                _local_2 = _data.getString(_rid, _textField);
                _arg_1.text = _local_2;
            };
            if (_placementField)
            {
                _arg_1.placement = _data.getString(_rid, _placementField);
            };
        }

        public function set placementField(_arg_1:String):*
        {
            _placementField = _arg_1;
        }

        public function set textField(_arg_1:String):*
        {
            _textField = _arg_1;
        }

        override public function updateSymbolStyle(_arg_1:Sprite):*
        {
            var _local_2:LabelField;
            _local_2 = new LabelField(_arg_1, "label");
            updateLabelField(_local_2);
        }


    }
}//package mb

