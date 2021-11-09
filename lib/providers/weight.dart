import 'package:flutter/cupertino.dart';
import 'package:weighttracker/database/database_abstraction.dart';
import 'package:weighttracker/database/entities/weight.dart';

class WeightProvider with ChangeNotifier {
  List<Weight> weightList = [];
  double averageWeight = 0;

  IDatabase db;

  WeightProvider(this.db) {
    _updateData();
  }

  void addWeight(double weight, DateTime dateTime) {
    db.addWeight(Weight(weight, dateTime));
    _updateData();
    notifyListeners();
  }

  void sortList() {
    weightList.sort((obj1, obj2) => obj1.time.isAfter(obj2.time) ? -1 : 1);
  }

  void _updateData() {
    weightList.clear();
    weightList.addAll(db.getWeights());
    sortList();
    averageWeight = db.getAverageWeight();
  }
}
