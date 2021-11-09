import 'package:flutter/material.dart';
import 'package:weighttracker/providers/weight.dart';
import 'package:weighttracker/routes/add_weight.dart';
import 'package:weighttracker/database/entities/weight.dart';
import 'package:weighttracker/utils.dart';
import 'package:provider/provider.dart';

class WeightListRoute extends StatefulWidget {
  const WeightListRoute({Key? key}) : super(key: key);

  @override
  State<WeightListRoute> createState() => _WeightListRouteState();
}

class _WeightListRouteState extends State<WeightListRoute> {
  double _averageWeight = 0;

  void _updateData() {
    setState(() {
      _averageWeight++;
    });
  }

  void _navigateToAddWeightRoute() {
    // navigate to next screen
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddWeightRoute()));
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    final List<Weight> _weightList = context.watch<WeightProvider>().weightList;

    return SafeArea(
      child: Scaffold(
        appBar: null,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: _screenHeight * .30, // covering 30% of screen
              floating: false,
              pinned: false,
              snap: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(context.watch<WeightProvider>().averageWeight.toStringAsFixed(2),
                        style: const TextStyle(fontSize: 45, color: Colors.white)),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "Average Weight",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
              Weight _listData = _weightList[index];
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Text(
                          "${_listData.weight.toStringAsFixed(2)} Kg",
                          style: const TextStyle(fontSize: 17, color: Colors.black87),
                        ),
                        Expanded(child: Container()),
                        Text(
                          Utils.getFormattedDate(_listData.time),
                          style: const TextStyle(fontSize: 17, color: Colors.black38),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    color: Colors.black12,
                  )
                ],
              );
            }, childCount: _weightList.length)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _navigateToAddWeightRoute,
          tooltip: 'Navigate to next screen',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
