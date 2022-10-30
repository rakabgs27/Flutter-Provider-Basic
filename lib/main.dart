import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Person with ChangeNotifier {
  String name;
  int age;
  Person({
    required this.name, 
    required this.age
    });

  void increaseAge() {
    age++;
    notifyListeners();
  }

  void changeName() {
    name = "Gary";
    notifyListeners();
  }
}

class Countdown {
  static Stream<String> start() async* {
    var i = 10;
    while (i > 0) {
      await Future.delayed(Duration(seconds: 1), () {
        i++;
        i--;
      });
      yield i.toString();
    }

    yield "bLAsT oFf !!!";
  }
}

void main() {
  runApp(
   MultiProvider(
      providers: [
        StreamProvider<String>(
          create: (_) => Countdown.start(),
          initialData: "Begin countdown...",
          catchError: (_, error) => error.toString(),
        ),
        ChangeNotifierProvider<Person>(
          create: (_) => Person(name: 'Ghani', age: 25),
        ),
      ],
      child: MyApp(),
   )
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text("Context Provider"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text_tengah(),
        ),
        floatingActionButton: button_increase(),
      );
    }
  }

    class Text_tengah extends StatelessWidget {
      const Text_tengah({
        Key? key,
      }) : super(key: key);

      @override
      Widget build(BuildContext context) {
        return Center(
          child: Column(
            children: <Widget>[
              Text("Name: ${context.select(
                (Person p) => p.name,
                )}"),
              Text("context.select: ${context.select((Person p) => p.age)}"),
              Text("context.watch: ${context.watch<String>()}"),
            ],
          )
        );
    }
  }

  class button_increase extends StatelessWidget {
  const button_increase({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.read<Person>().increaseAge();
      },
    );
  }
}