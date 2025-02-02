import 'package:flutter/material.dart';

void main() {
  runApp(const Chess());
}

class Chess extends StatelessWidget {
  const Chess({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Test'),
        ),
        body: const Center(
          child: Text('Test'),
        ),
      ),
    );
  }
}