import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weighttracker/database/database_abstraction.dart';
import 'package:weighttracker/entities/weight.dart';

class Database extends IDatabase {
  final SharedPreferences prefs;

  static const _listKey = "weight_list_key_sp";

  Database(this.prefs);

  @override
  void addWeight(Weight weight) {
    final list = getWeights();
    list.add(weight);
    _updateList(list);
  }

  @override
  double getAverageWeight() {
    final list = getWeights();
    double sum = 0;
    for (var weight in list) {
      sum += weight.weight;
    }
    return sum / list.length;
  }

  @override
  List<Weight> getWeights() {
    final jsonListStr = prefs.getString(_listKey);
    print(jsonListStr);
    if (jsonListStr?.isNotEmpty ?? false) {
      Iterable l = json.decode(jsonListStr!);
      List<Weight> weights = List<Weight>.from(l.map((model) => Weight.fromJson(model)));
      return weights;
    }
    return [];
  }

  void _updateList(List<Weight> list) {
    final jsonList = json.encode(list.map((e) => e.toJson()).toList());
    prefs.setString(_listKey, jsonList);
  }
}
