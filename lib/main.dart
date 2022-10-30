import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Person {
  final String name;
  int age;
  Person({
    required this.name, 
    required this.age
    });
}

class Home {
  final String city = "Portland";

  Future<String> get fetchAddress {
    final address = Future.delayed(const Duration(seconds: 5), () {
      return '1234 North Commercial Ave.';
    });

    return address;
  }
}

void main() {
  runApp(
   MultiProvider(
      providers: [
        Provider<Person>(
          create: (context) => Person(name: 'Raka', age: 22),
        ),
        FutureProvider(create: ((context) => Home().fetchAddress),
        initialData: "Fetching Address",
        )
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
        title: Text("Future Provider"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Consumer<Person>(
            builder: (context, Person person, child) {
              return Column(
                children: <Widget>[
                  Text("User profile:"),
                  Text("name: ${person.name}"),
                  Text("age: ${person.age}"),
                  Consumer<String>(builder: (context, String address, child) {
                    return Text("address: $address");
                  }),
                ],
              );
            },
          ),
        ),
      )
    );
}
}