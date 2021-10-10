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

  VisualNotifier(
    int max,
    int height,
    int type,
  ) {
    setAlgorithmTypeOnly(type);
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

  void setAlgorithmTypeOnly(int type) {
    algorithmType = type;
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
      case 1:
        kDuration = const Duration(microseconds: 1000);
        await _selectionSortVisualiser();
        break;
      case 2:
        kDuration = const Duration(microseconds: 300);
        await _insertionSortVisualiser();
        break;
      case 3:
        kDuration = const Duration(microseconds: 1000);
        await _mergeSortVisualiser(arrayOfBars, 0, arrayOfBars.length - 1);
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

  // Selection sort
  _selectionSortVisualiser() async {
    int minIndex = 0;

    for (int i = 0; i < arrayOfBars.length - 1; i++) {
      minIndex = i;
      for (int j = i + 1; j < arrayOfBars.length; j++) {
        if (!isRunning) return;

        if (arrayOfBars[j] < arrayOfBars[minIndex]) {
          minIndex = j;
        }
      }

      await swap(i, minIndex);
    }
  }

  // Insertion sort
  _insertionSortVisualiser() async {
    int key, j;

    for (int i = 1; i < arrayOfBars.length; i++) {
      key = arrayOfBars[i];
      j = i - 1;

      while (j >= 0 && arrayOfBars[j] > key) {
        if (!isRunning) return;

        await Future.delayed(kDuration, () {
          arrayOfBars[j + 1] = arrayOfBars[j];
          notifyListeners();
        });

        j = j - 1;
      }

      await Future.delayed(kDuration, () {
        arrayOfBars[j + 1] = key;
      });
    }

    isRunning = false;
    notifyListeners();
  }

  // Merge sort
  _mergeSortVisualiser(List<int> mergeArr, int low, int high) async {
    if (low < high) {
      if (!isRunning) return;

      int mid = (low + (high - low) / 2).toInt();
      await _mergeSortVisualiser(mergeArr, low, mid);
      await _mergeSortVisualiser(mergeArr, mid + 1, high);
      _updateArrayWithDelay(mergeArr);
      await merge(mergeArr, low, mid, high);
    }
  }

  merge(List<int> mergeArr, int low, int mid, int high) async {
    int i, j, k;
    int n1 = mid - low + 1;
    int n2 = high - mid;

    /* create temp arrays */
    List<int> L = [], R = [];

    /* Copy data to temp arrays L[] and R[] */
    for (i = 0; i < n1; i++) {
      L.add(mergeArr[low + i]); //L[i] = mergeArr[low + i];
    }
    for (j = 0; j < n2; j++) {
      R.add(mergeArr[mid + 1 + j]); //R[j] = mergeArr[mid + 1 + j];
    }

    i = 0;
    j = 0;
    k = low;
    while (i < n1 && j < n2) {
      if (!isRunning) return;

      if (L[i] <= R[j]) {
        mergeArr[k] = L[i];
        i++;
      } else {
        mergeArr[k] = R[j];
        j++;
      }
      await _updateArrayWithDelay(mergeArr);
      k++;
    }

    while (i < n1) {
      if (!isRunning) return;
      mergeArr[k] = L[i];
      i++;
      k++;
    }

    while (j < n2) {
      if (!isRunning) return;
      mergeArr[k] = R[j];
      j++;
      k++;
    }
  }

  _updateArrayWithDelay(List<int> updatedArr) async {
    await Future.delayed(kDuration, () {
      arrayOfBars = List.from(updatedArr);
      if (isSorted()) isRunning = false;
      notifyListeners();
    });
  }
}
