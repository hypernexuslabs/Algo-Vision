import 'package:algo_vision/widgets/app_primary_button.dart';
import 'package:flutter/material.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 10/10/21 at 5:09 pm
///

class HomePage extends StatelessWidget {
  static const route = "/home-page";

  const HomePage({Key? key}) : super(key: key);

  final List<String> algorithms = const ["Quick Sort"];

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
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
