import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trade_power_tracker/providers/app_provider.dart';
import 'package:trade_power_tracker/screens/dashboard_screen.dart';
import 'package:trade_power_tracker/screens/trade_power_screen.dart';
import 'package:trade_power_tracker/screens/withdrawal_screen.dart';
import 'package:trade_power_tracker/screens/compounding_screen.dart';
import 'package:trade_power_tracker/screens/settings_screen.dart';

void main() {
  runApp(const TradePowerTrackerApp());
}

class TradePowerTrackerApp extends StatelessWidget {
  const TradePowerTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: MaterialApp(
        title: 'Trade Power Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MainScreen(),
        routes: {
          '/dashboard': (context) => const DashboardScreen(),
          '/trade_power': (context) => const TradePowerScreen(),
          '/withdrawals': (context) => const WithdrawalScreen(),
          '/compounding': (context) => const CompoundingScreen(),
          '/settings': (context) => const SettingsScreen(),
        },
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    TradePowerScreen(),
    WithdrawalScreen(),
    CompoundingScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trade Power Tracker'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Trade Power',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money_off),
            label: 'Withdrawals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Compounding',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}