import 'package:flutter/material.dart';

class ScorePage extends StatefulWidget {
  final List<int?> answers;
  const ScorePage({super.key, required this.answers});

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Text('Splash'),
        ],
      ),
    );
  }
}
