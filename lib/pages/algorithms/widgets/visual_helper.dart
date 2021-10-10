///
/// Created by Auro (auro@smarttersstudio.com) on 10/10/21 at 6:44 pm
///

import 'dart:async';
import 'package:flutter/cupertino.dart';

class VisualNotifier with ChangeNotifier {
  List<int> arrayOfBars = [];
  Duration kDuration = const Duration(microseconds: 1000);

  var count = 0;
  var isRunning = false;

  // sizes
  var maxBars = 0;
  var maxHeight = 0;

  var algorithmType = 0;

  VisualNotifier(int max, int height) {
    maxBars = max;
    maxHeight = height;
    getVisualBars(max, height);
  }

  void getVisualBars(int maxSize, int maxHeight) {
    arrayOfBars.clear();

    List<int> tmpArray = [];
    for (int i = 1; i <= maxSize; i++) {
      var height = (i * maxHeight) ~/ maxSize;
      tmpArray.add((height));
    }

    tmpArray.shuffle();
    arrayOfBars = tmpArray;
    notifyListeners();
  }

  void setAlgorithmType(int type) {
    isRunning = false;
    algorithmType = type;
    resetBars();
    notifyListeners();
  }

  void pause() {
    isRunning = false;
    notifyListeners();
  }

  void resetBars() {
    isRunning = false;
    getVisualBars(maxBars, maxHeight);
  }

  bool isSorted() {
    for (int i = 0; i < arrayOfBars.length - 1; i++) {
      if (arrayOfBars[i] > arrayOfBars[i + 1]) {
        return false;
      }
    }
    return true;
  }

  // swap
  swap(int i, int j) async {
    await Future.delayed(kDuration, () {
      int tmp = arrayOfBars[i];
      arrayOfBars[i] = arrayOfBars[j];
      arrayOfBars[j] = tmp;

      if (isSorted()) isRunning = false;

      notifyListeners();
    });
  }

  start() async {
    isRunning = true;

    switch (algorithmType) {
      case 0:
        kDuration = const Duration(microseconds: 1000);
        await _quickSort(arrayOfBars, 0, arrayOfBars.length - 1);
        break;
    }
  }

  // Quick sort
  _quickSort(List<int> arrInt, int low, int high) async {
    if (low < high) {
      int pi = await quickPartition(arrInt, low, high);
      await _quickSort(arrInt, low, pi - 1);
      await _quickSort(arrInt, pi + 1, high);
    }
  }

  Future<int> quickPartition(List<int> arr, int low, int high) async {
    int pivot = arr[high];

    int i = (low - 1);
    for (int j = low; j <= high - 1; j++) {
      if (arr[j] < pivot) {
        i++;
        await swap(i, j);
      }
    }

    await swap(i + 1, high);
    return (i + 1);
  }
}
