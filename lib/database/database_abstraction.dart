import 'package:weighttracker/database/entities/weight.dart';

abstract class IDatabase {
  void addWeight(Weight weight);

  double getAverageWeight();

  List<Weight> getWeights();
}
