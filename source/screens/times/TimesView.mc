import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Lang;
import Toybox.Timer;

class TimesView extends WatchUi.View {

    var times as Array<Float> = new [0];
    var cursor as Number = -1;

    var labels as Array = new[5];

    function initialize() {
        View.initialize();
    }

    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.Times(dc));
        labels[0] = findDrawableById("time1_label");
        labels[1] = findDrawableById("time2_label");
        labels[2] = findDrawableById("time3_label");
        labels[3] = findDrawableById("time4_label");
        labels[4] = findDrawableById("time5_label");
    }

    function onShow() as Void {
        fetchFromRepo();
        renderLabels();
    }

    function onUpdate(dc as Dc) as Void {
        View.onUpdate(dc);
    }

    function onHide() as Void {
    }

    function fetchFromRepo() as Void {
        times = TimesRepository.getInstance().getTimes();
        cursor = times.size() - 1;
    }

    function goUp() as Void {
        if (cursor > 0) {
            cursor--;
        }
        renderLabels();
    }

    function goDown() as Void {
        if (cursor < times.size() - 1) {
            cursor++;
        }
        renderLabels();
    }

    function selected() as Void {
        // TODO show confirmation before removing
        times = TimesRepository.getInstance().deleteTime(cursor);
        if (cursor >= times.size()) {
            cursor = times.size() - 1;
        }
        renderLabels();
    }

    function renderLabels() as Void {
        if (cursor >= 2) {
            labels[0].setText("...");
        } else {
            labels[0].setText("");
        }
        if (cursor > 0) {
            labels[1].setText(times[cursor - 1].format("%.2f"));
        } else {
            labels[1].setText("");
        }
        labels[2].setText(times[cursor].format("%.2f"));
        if (cursor + 1 < times.size()) {
            labels[3].setText(times[cursor + 1].format("%.2f"));
        } else {
            labels[3].setText("");
        }
        if (cursor + 2 <= times.size() - 1) {
            labels[4].setText("...");
        } else {
            labels[4].setText("");
        }
        WatchUi.requestUpdate();
    }
}
