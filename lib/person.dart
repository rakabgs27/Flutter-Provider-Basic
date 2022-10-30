import 'package:flutter/material.dart';

class Person with ChangeNotifier {
  String name;
  int age;

  Person({
    required this.name,
    required this.age,
  });

  void increaseAge(){
    age++;
    notifyListeners();
  }
}
