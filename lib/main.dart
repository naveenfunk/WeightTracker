import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weighttracker/database/database.dart';
import 'package:weighttracker/providers/weight.dart';
import 'package:weighttracker/routes/weight_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();
  runApp(MultiProvider(providers: [ChangeNotifierProvider(create: (_) => WeightProvider(Database(prefs)))], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WeightListRoute(),
    );
  }
}
