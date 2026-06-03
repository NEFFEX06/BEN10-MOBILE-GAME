import 'package:flutter/material.dart';

class GameProvider extends ChangeNotifier {
  int _coins = 1000;
  int _totalScore = 0;
  bool _isSoundEnabled = true;
  bool _hasUltimatrix = false;
  String _currentMap = 'city';
  
  int get coins => _coins;
  int get totalScore => _totalScore;
  bool get isSoundEnabled => _isSoundEnabled;
  bool get hasUltimatrix => _hasUltimatrix;
  String get currentMap => _currentMap;

  void addCoins(int amount) {
    _coins += amount;
    notifyListeners();
  }

  void spendCoins(int amount) {
    if (_coins >= amount) {
      _coins -= amount;
      notifyListeners();
    }
  }

  void addScore(int amount) {
    _totalScore += amount;
    notifyListeners();
  }

  void toggleSound() {
    _isSoundEnabled = !_isSoundEnabled;
    notifyListeners();
  }

  void unlockUltimatrix() {
    _hasUltimatrix = true;
    notifyListeners();
  }

  void changeMap(String mapName) {
    _currentMap = mapName;
    notifyListeners();
  }

  void resetGame() {
    _coins = 1000;
    _totalScore = 0;
    _hasUltimatrix = false;
    _currentMap = 'city';
    notifyListeners();
  }
}
