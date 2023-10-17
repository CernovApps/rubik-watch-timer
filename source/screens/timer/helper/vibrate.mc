import Toybox.Lang;
import Toybox.Attention;

function vibrate(dutyCycle as Number, lengths as Array<Number>) as Void {
    if (Attention has :vibrate) {
        var profiles = new [lengths.size()];
        for (var i = 0; i < lengths.size(); i++) {
            profiles[i] = new Attention.VibeProfile(dutyCycle, lengths[i]);
        }

		Attention.vibrate(profiles);
	}
}
