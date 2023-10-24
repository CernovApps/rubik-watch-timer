import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class StatsLoopFactory extends WatchUi.ViewLoopFactory {
    var pages as Array<Array<Array<String>>>;

    function initialize() {
        ViewLoopFactory.initialize();

        var stats = TimesRepository.getInstance().getStats();
        pages = new [3];
        pages[0] = [["best", str(stats["best"])],["worst", str(stats["worst"])],["avg", str(stats["average"])]];
        pages[1] = [["avg 5", str(stats["avg5"])],["3 of 5", str(stats["3of5"])],["best 3 of 5", str(stats["best3of5"])]];
        pages[2] = [["avg 12", str(stats["avg12"])],["10 of 12", str(stats["10of12"])],["best 10 of 12", str(stats["best10of12"])]];
    }

    function str(value as Float or Null) as String {
        if (value == null) {
            return "-";
        } else {
            return value.format("%.2f");
        }
    }

    function getSize() as Number {
        return 3;
    }

    function getView(page as Number) as Array<WatchUi.View or WatchUi.BehaviorDelegate> or Null {
        var view = new StatsPageView(pages[page]);
        return [view, new WatchUi.BehaviorDelegate()];
    }
}
