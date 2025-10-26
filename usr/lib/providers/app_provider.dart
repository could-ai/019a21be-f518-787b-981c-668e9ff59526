import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  List<dynamic> _tradePowers = [];
  List<dynamic> _withdrawals = [];
  Map<String, bool> _settings = {'autoAddTp': false, 'autoBackup': false};

  List<dynamic> get tradePowers => _tradePowers;
  List<dynamic> get withdrawals => _withdrawals;
  Map<String, bool> get settings => _settings;

  void setTradePowers(List<dynamic> tradePowers) {
    _tradePowers = tradePowers;
    notifyListeners();
  }

  void setWithdrawals(List<dynamic> withdrawals) {
    _withdrawals = withdrawals;
    notifyListeners();
  }

  void updateSettings(Map<String, bool> settings) {
    _settings = settings;
    notifyListeners();
  }
}