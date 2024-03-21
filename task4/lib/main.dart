import 'package:flutter/material.dart';

void main() {
  return runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Animals'),
          backgroundColor: Colors.blueAccent,
        ),
        body: AnimalsPage(),
      ),
    ),
  );
}

class AnimalsPage extends StatefulWidget {
  const AnimalsPage({super.key});

  @override
  State<AnimalsPage> createState() => _AnimalsPageState();
}

class _AnimalsPageState extends State<AnimalsPage> {
  int indexAnimal = 0;

  List<String> animals = [
    'elephant',
    'lion',
    'giraffe',
    'monkey',
    'zebra',
    'tiger',
  ];
  void selectAnimal(int index) {
    setState(() {
      indexAnimal = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'images/${animals[indexAnimal]}.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<String>(
            value: animals[indexAnimal],
            items: animals.map((String animal) {
              return DropdownMenuItem<String>(
                value: animal,
                child: Text(animal),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                indexAnimal = animals.indexOf(value!);
              });
            },
          ),
        ),
      ],
    ));
  }
}
