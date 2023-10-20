import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Lang;
import Toybox.Timer;

class TimesView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.Times(dc));
    }

    function onShow() as Void {
    }

    function onUpdate(dc as Dc) as Void {
        View.onUpdate(dc);
    }

    function onHide() as Void {
    }
}
