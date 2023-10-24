import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Lang;
import Toybox.Timer;

class ConfirmView extends WatchUi.View {

    var _label;
    var message as String = "";

    function initialize() {
        View.initialize();
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.Confirm(dc));
        _label = findDrawableById("main_label");
    }

    function onShow() as Void {
        _label.setText(message);
    }

    function onUpdate(dc as Dc) as Void {
        View.onUpdate(dc);
    }

    function onHide() as Void {
    }

    function selected() as Boolean {
      WatchUi.popView(WatchUi.SLIDE_DOWN);
      return true;
    }
}
