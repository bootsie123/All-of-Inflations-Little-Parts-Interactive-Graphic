// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//CPI3_fla.MainTimeline

package CPI3_fla
{
    import flash.display.MovieClip;
    import flash.display.*;
    import flash.text.*;
    import flash.geom.*;
    import flash.filters.*;
    import flash.events.*;
    import flash.utils.*;
    import flash.net.*;
    import adobe.utils.*;
    import flash.accessibility.*;
    import flash.errors.*;
    import flash.external.*;
    import flash.media.*;
    import flash.printing.*;
    import flash.system.*;
    import flash.ui.*;
    import flash.xml.*;

    public dynamic class MainTimeline extends MovieClip 
    {

        public var callouts_mc:MovieClip;
        public var map_mc:MovieClip;
        public var labels0_mc:MovieClip;
        public var zoom_mc:MovieClip;
        public var details_mc:MovieClip;
        public var chart:CPI;

        public function MainTimeline()
        {
            addFrameScript(0, frame1);
        }

        internal function frame1():*
        {
            chart = new CPI(map_mc.align_mc);
        }


    }
}//package CPI3_fla

