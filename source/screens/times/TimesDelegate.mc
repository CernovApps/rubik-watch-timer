import Toybox.Lang;
import Toybox.WatchUi;

class TimesDelegate extends WatchUi.BehaviorDelegate {
    private var _view as TimesView;

    function initialize(view as TimesView) {
        _view = view;
        BehaviorDelegate.initialize();
    }
}
