import Toybox.Lang;
import Toybox.WatchUi;

class TimesDelegate extends WatchUi.BehaviorDelegate {
    private var _view as TimesView;

    function initialize(view as TimesView) {
        _view = view;
        BehaviorDelegate.initialize();
    }

    function onSelect() as Boolean {
        _view.selected();
        return true;
    }

    function onNextPage() as Boolean {
        _view.goDown();
        return true;
    }

    function onPreviousPage() as Boolean {
        _view.goUp();
        return true;
    }
}
