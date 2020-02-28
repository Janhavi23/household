import 'package:flutter/material.dart';
import 'package:household_app/Screen1.dart';

void main() => runApp(HouseholdApp());

class HouseholdApp extends StatefulWidget {
  @override
  _HouseHold_aState createState() => _HouseHold_aState();
}

class _HouseHold_aState extends State<HouseholdApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Screen1(),
    );
  }
}
