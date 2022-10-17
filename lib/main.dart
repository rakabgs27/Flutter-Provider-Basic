import 'package:testingprovider/person.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
   ChangeNotifierProvider(
      create: (_) => Person(name: " Raka Bagas Fitriansyah", age: 20),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyNamePage(),
    );
  }
}

class MyNamePage extends StatelessWidget {
  const MyNamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Title'),
      ),
      body: Center(
        child: 
          Text(
           '''
          Hi ${Provider.of<Person>(context).name}!
          You are ${Provider.of<Person>(context).age} years old''',
          style: const TextStyle(
            fontSize: 20
          ),
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Provider.of<Person>(context,listen: false).increaseAge();
      },
      child: Icon(Icons.add),
      ),
    );
  }
}