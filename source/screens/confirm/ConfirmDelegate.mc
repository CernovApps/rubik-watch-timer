import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class ConfirmDelegate extends WatchUi.BehaviorDelegate {
    var _view as ConfirmView;
    var _callback as Method();

    function initialize(view as ConfirmView, message as String, callback as Method()) {
        _view = view;
        _callback = callback;
        BehaviorDelegate.initialize();
        _view.message = message;
    }

    function onSelect() as Boolean {
        _view.selected();
        _callback.invoke();
        return true;
    }
}
