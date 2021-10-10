import 'package:algo_vision/pages/algorithms/algorithm_visualizer.dart';
import 'package:algo_vision/pages/home/home_page.dart';
import 'package:get/get.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 10/10/21 at 4:54 pm
///

class AppPages {
  static final pages = [
    GetPage(
      name: HomePage.routeName,
      page: () => const HomePage(),
    ),
    GetPage(
      name: AlgorithmVisualizer.routeName,
      page: () => const AlgorithmVisualizer(),
    ),
  ];
}
