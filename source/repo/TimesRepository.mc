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
    var allValuesResult = statsFor(times);
    var resultAvg5 = null;
    var result3of5 = null;
    var resultAvg12 = null;
    var result10of12 = null;

    if (times.size() >= 5) {
      var fiveResult = statsFor(times.slice(-5, null));
      resultAvg5 = fiveResult["avg"];
      result3of5 = fiveResult["noEdges"];
    }

    if (times.size() >= 12) {
      var twelveResult = statsFor(times.slice(-12, null));
      resultAvg12 = twelveResult["avg"];
      result10of12 = twelveResult["noEdges"];
    }

    return {
      "best" => allValuesResult["best"],
      "worst" => allValuesResult["worst"],
      "average" => allValuesResult["avg"],
      "avg5" => resultAvg5,
      "3of5" => result3of5,
      "avg12" => resultAvg12,
      "10of12" => result10of12
    };
  }

  // Returns array with size 3. times.size() must be >0
  function statsFor(times as Array<Float>) as Dictionary<String, Float> {
    var best = times[0];
    var worst = times[0];
    var total = 0.0;

    for (var i = 0; i < times.size(); i++) {
      var num = times[i];
      if (num < best) {
        best = num;
      }
      if (num > worst) {
        worst = num;
      }
      total += num;
    }
    var avg = total / times.size();
    var noEdges = (total - best - worst) / (times.size() - 2);
    return {"best" => best, "worst" => worst, "avg" => avg, "noEdges" => noEdges};
  }
}
