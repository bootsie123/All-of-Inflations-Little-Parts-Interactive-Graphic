// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//mb.Waiter

package mb
{
    public class Waiter extends Notifier 
    {

        private var paramsObj:Object;
        private var _name:String;
        private var dependenciesArr:Array;

        public function Waiter(_arg_1:String="")
        {
            _name = _arg_1;
            dependenciesArr = [];
            paramsObj = {};
        }

        public function get name():String
        {
            return (_name);
        }

        public function addDependency(_arg_1:Object):*
        {
            if (!_arg_1)
            {
                return;
            };
            if (this.ready)
            {
            };
            dependenciesArr.push(_arg_1);
        }

        public function startWaiting():*
        {
            monitorDependencies();
        }

        public function waitFor(_arg_1:Object):*
        {
            addDependency(_arg_1);
        }

        public function checkDependencies(_arg_1:Object=null):*
        {
            var _local_2:String;
            if (this.ready)
            {
                return;
            };
            for (_local_2 in dependenciesArr)
            {
                if (!dependenciesArr[_local_2].ready)
                {
                    return;
                };
            };
            handleReadyState();
            notifyReady();
        }

        final override protected function notifyReady(_arg_1:Object=null):*
        {
            dependenciesArr = [];
            super.notifyReady();
        }

        public function setParameter(_arg_1:String, _arg_2:Object):*
        {
            paramsObj[_arg_1] = _arg_2;
        }

        public function monitorDependencies():*
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:Object;
            if (this.ready)
            {
            };
            if (dependenciesArr.length == 0)
            {
                handleReadyState();
                notifyReady();
                return;
            };
            _local_1 = dependenciesArr.length;
            _local_2 = 0;
            while (_local_2 < _local_1)
            {
                if (this.ready) break;
                _local_3 = dependenciesArr[_local_2];
                _local_3.setCallback(this, checkDependencies, READY);
                _local_2++;
            };
        }

        public function getParameter(_arg_1:String):Object
        {
            return (paramsObj[_arg_1]);
        }

        protected function handleReadyState():*
        {
        }


    }
}//package mb

