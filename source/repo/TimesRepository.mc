import Toybox.Lang;

using Toybox.Application.Storage;

const TIMES_STORAGE_KEY = "times";

class TimesRepository {
  private static var instance;
  
  static function getInstance() as TimesRepository {
    if (instance == null) {
      instance = new TimesRepository();
    }
    return instance;
  }

  private function initialize() {
  }

  function getTimes() as Array<Float> {
    var result = Storage.getValue(TIMES_STORAGE_KEY);
    if (result == null) {
      return [];
    } else {
      return result;
    }
  }

  function pushTime(time as Float) as Void {
    var times = getTimes();
    times.add(time);
    Storage.setValue(TIMES_STORAGE_KEY, times);
  }

  function deleteTime(index as Number) as Array<Float> {
    var times = getTimes();
    var result = times.slice(0, index).addAll(times.slice(index+1, null));
    Storage.setValue(TIMES_STORAGE_KEY, result);    
    return result;
  }

  function reset() as Void {
    Storage.deleteValue(TIMES_STORAGE_KEY);
  }

  function getStats() as Dictionary<String, Float or Null> {
    var times = getTimes();
    if (times.size() == 0) {
      return {};
    }
    var best = times[0];
    var worst = times[0];
    var avg = 0.0;

    for (var i = 0; i < times.size(); i++) {
      var num = times[i];
      if (num < best) {
        best = num;
      }
      if (num > worst) {
        worst = num;
      }
      avg += num;
    }
    avg /= times.size();

    return {
      "best" => best,
      "worst" => worst,
      "average" => avg,
      "avg5" => null,
      "3of5" => null,
      "best3of5" => null,
      "avg12" => null,
      "10of12" => null,
      "best10of12" => null
    };
  }
}
