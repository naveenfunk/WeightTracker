import 'package:weighttracker/utils.dart';

class Weight {
  double weight = 0;
  DateTime time;

  Weight(this.weight, this.time);

  Map<String, dynamic> toJson() {
    return {"weight": weight, "time": Utils.getFormattedDate(time)};
  }

  Weight.fromJson(Map<String, dynamic> json)
      : weight = json["weight"],
        time = Utils.getDateFromString(json["time"]);
}
