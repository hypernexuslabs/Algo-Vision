import 'package:flutter/material.dart';
import 'package:algo_vision/config/app_colors.dart';
import 'package:algo_vision/pages/algorithms/widgets/visual_helper.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 10/10/21 at 6:21 pm
///

class AlgorithmVisualizer extends StatefulWidget {
  static const routeName = "/algo-visualizer";

  const AlgorithmVisualizer({Key? key}) : super(key: key);

  @override
  _AlgorithmVisualizerState createState() => _AlgorithmVisualizerState();
}

class _AlgorithmVisualizerState extends State<AlgorithmVisualizer> {
  double topStatus = 0;
  double bottomStatus = 0;
  int algorithmType = 0;
  String appBarName = "";

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> args = Get.arguments ?? {};
    algorithmType = args["algorithmType"] ?? 0;
    appBarName = args["appBarName"] ?? "";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    topStatus = MediaQuery.of(context).padding.top;
    bottomStatus = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      appBar: AppBar(
        title: Text("$appBarName"),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: ChangeNotifierProvider<VisualNotifier>(
          create: (context) => VisualNotifier(
              (size.width).toInt(), (size.height * 0.6).toInt(), algorithmType),
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLight,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 4.0), //(x,y)
                        blurRadius: 16.0,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.only(
                      left: 0, top: topStatus + 8, right: 0, bottom: 0),
                  child: Consumer<VisualNotifier>(
                    builder: (context, mVisualizer, child) {
                      return ClipRRect(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Align(
                              alignment: Alignment.bottomCenter,
                              child: Wrap(
                                children: [
                                  Container(
                                    width: 1,
                                    height: mVisualizer.arrayOfBars[index]
                                        .toDouble(),
                                    color: AppColors.primary,
                                  ),
                                ],
                              ),
                            );
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: mVisualizer.arrayOfBars.length,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 60,
                right: 30,
                child: Consumer<VisualNotifier>(
                  builder: (context, mVisualizer, child) {
                    return Row(
                      children: [
                        Card(
                          color: mVisualizer.isRunning
                              ? AppColors.red
                              : Colors.orange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: IconButton(
                            icon: Icon(
                              mVisualizer.isRunning
                                  ? Icons.stop
                                  : Icons.play_arrow,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              if (mVisualizer.isRunning) {
                                mVisualizer.resetBars();
                              } else {
                                await mVisualizer.start();
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Card(
                          color: Colors.orange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: IconButton(
                            icon: const Icon(
                              Icons.autorenew_sharp,
                              color: Colors.white,
                            ),
                            onPressed: () => mVisualizer.resetBars(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getAlgoBadgeWidget(String text, bool isSelected, VoidCallback onHit) {
    return InkWell(
      onTap: onHit,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14.0),
        decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            border: isSelected
                ? null
                : Border.all(color: AppColors.primary, width: 1)),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: isSelected ? Colors.white : AppColors.primary,
          ),
        ),
      ),
    );
  }
}
