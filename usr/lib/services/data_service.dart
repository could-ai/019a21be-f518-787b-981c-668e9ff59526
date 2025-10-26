import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trade_power_tracker/models/trade_power.dart';
import 'package:trade_power_tracker/models/withdrawal.dart';

class DataService {
  static const String _tradePowersKey = 'tradePowers';
  static const String _withdrawalsKey = 'withdrawals';
  static const String _autoAddTpKey = 'autoAddTp';
  static const String _autoBackupKey = 'autoBackup';

  // Load Trade Powers
  Future<List<TradePower>> loadTradePowers() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_tradePowersKey);
    if (data != null) {
      final List<dynamic> jsonList = json.decode(data);
      return jsonList.map((json) => TradePower.fromJson(json)).toList();
    }
    return [];
  }

  // Save Trade Powers
  Future<void> saveTradePowers(List<TradePower> tradePowers) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = tradePowers.map((tp) => tp.toJson()).toList();
    await prefs.setString(_tradePowersKey, json.encode(jsonList));
  }

  // Load Withdrawals
  Future<List<Withdrawal>> loadWithdrawals() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_withdrawalsKey);
    if (data != null) {
      final List<dynamic> jsonList = json.decode(data);
      return jsonList.map((json) => Withdrawal.fromJson(json)).toList();
    }
    return [];
  }

  // Save Withdrawals
  Future<void> saveWithdrawals(List<Withdrawal> withdrawals) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = withdrawals.map((w) => w.toJson()).toList();
    await prefs.setString(_withdrawalsKey, json.encode(jsonList));
  }

  // Export all data to JSON string
  Future<String> exportData() async {
    final tradePowers = await loadTradePowers();
    final withdrawals = await loadWithdrawals();
    final data = {
      'tradePowers': tradePowers.map((tp) => tp.toJson()).toList(),
      'withdrawals': withdrawals.map((w) => w.toJson()).toList(),
    };
    return json.encode(data);
  }

  // Import data from JSON string
  Future<void> importData(String jsonData) async {
    final data = json.decode(jsonData);
    final tradePowers = (data['tradePowers'] as List)
        .map((json) => TradePower.fromJson(json))
        .toList();
    final withdrawals = (data['withdrawals'] as List)
        .map((json) => Withdrawal.fromJson(json))
        .toList();
    await saveTradePowers(tradePowers);
    await saveWithdrawals(withdrawals);
  }

  // Calculate earnings (placeholder logic - will expand)
  double calculateTodayEarnings(List<TradePower> activeTps) {
    // Simple calculation: assume 1% daily earnings per TP
    return activeTps.where((tp) => tp.isActive).fold(0.0, (sum, tp) => sum + (tp.value * 0.01));
  }

  // Load settings
  Future<Map<String, bool>> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'autoAddTp': prefs.getBool(_autoAddTpKey) ?? false,
      'autoBackup': prefs.getBool(_autoBackupKey) ?? false,
    };
  }

  // Save settings
  Future<void> saveSettings(Map<String, bool> settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_autoAddTpKey, settings['autoAddTp'] ?? false);
    await prefs.setBool(_autoBackupKey, settings['autoBackup'] ?? false);
  }
}