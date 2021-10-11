import 'package:algo_vision/pages/algorithms/algorithm_visualizer.dart';
import 'package:algo_vision/widgets/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 10/10/21 at 5:09 pm
///

class HomePage extends StatelessWidget {
  static const routeName = "/";

  const HomePage({Key? key}) : super(key: key);

  final List<String> algorithms = const [
    "Quick Sort",
    "Selection Sort",
    "Insertion Sort",
    "Merge Sort",
    "Heap Sort",
    "Gnome Sort",
    "Bubble Sort"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Algo Vision"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: algorithms.length,
        itemBuilder: (c, i) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: AppPrimaryButton(
            child: Text("${algorithms[i]}"),
            onPressed: () {
              Get.toNamed(AlgorithmVisualizer.routeName, arguments: {
                "appBarName": algorithms[i],
                "algorithmType": i,
              });
            },
          ),
        ),
      ),
    );
  }
}
