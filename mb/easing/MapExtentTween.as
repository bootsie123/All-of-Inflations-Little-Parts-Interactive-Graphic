// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.easing.MapExtentTween

package mb.easing
{
    import mb.MapExtent;

    public class MapExtentTween implements ITween 
    {

        private var _method:Function;
        private var _a:MapExtent;
        private var _b:MapExtent;
        private var _done:Boolean = false;
        private var _callback:Function;

        public function MapExtentTween(_arg_1:Function, _arg_2:Function, _arg_3:MapExtent, _arg_4:MapExtent)
        {
            _a = _arg_3;
            _b = _arg_4;
            _method = _arg_1;
            _callback = _arg_2;
        }

        public function procTween(_arg_1:Number):*
        {
            var _local_2:MapExtent;
            var _local_3:Number;
            var _local_4:Number;
            if (_done)
            {
                return;
            };
            _arg_1 = _method(_arg_1);
            if (_arg_1 >= 1)
            {
                _done = true;
            };
            _local_2 = _a.clone();
            _local_3 = _arg_1;
            _local_4 = (1 - _arg_1);
            _local_2.setBounds(((_a.left * _local_4) + (_b.left * _local_3)), ((_a.top * _local_4) + (_b.top * _local_3)), ((_a.right * _local_4) + (_b.right * _local_3)), ((_a.bottom * _local_4) + (_b.bottom * _local_3)));
            _callback(_local_2, _done);
        }


    }
}//package mb.easing

