import Toybox.Lang;
import Toybox.WatchUi;

class ResetDelegate extends WatchUi.BehaviorDelegate {
    var _view as ResetView;

    function initialize(view as ResetView) {
        _view = view;
        BehaviorDelegate.initialize();
    }

    function onSelect() as Boolean {
        return _view.selected();
    }
}
