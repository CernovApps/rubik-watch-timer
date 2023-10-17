import Toybox.Lang;
import Toybox.WatchUi;

class TimerDelegate extends WatchUi.BehaviorDelegate {

    private var _view as TimerView;

    function initialize(view as TimerView) {
        _view = view;
        BehaviorDelegate.initialize();
    }

    var _isPressingKey = false;
    function onKeyPressed(keyEvent as WatchUi.KeyEvent) as Boolean {
        _isPressingKey = true;
        if (keyEvent.getKey() == KEY_ENTER) {
            System.println("Going to pressedEnter");
            return _view.pressedEnter();
        }
        return false;
    }

    function onKeyReleased(keyEvent as WatchUi.KeyEvent) as Boolean {
        if (!_isPressingKey) {
            // This is happening on first render, where the user is
            // still pressing the button that triggered this screen
            return false;
        }
        if (keyEvent.getKey() == KEY_ENTER) {
            return _view.releasedEnter();
        }

        return true;
    }
}
