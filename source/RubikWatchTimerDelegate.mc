import Toybox.Lang;
import Toybox.WatchUi;

class RubikWatchTimerDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelect() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new MainMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }
}