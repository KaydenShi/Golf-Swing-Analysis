import 'package:flutter/material.dart';
import 'package:golf_swing_analysis/screens/drills_screen.dart';
import 'package:golf_swing_analysis/screens/progress_screen.dart';
import 'package:golf_swing_analysis/screens/profile_screen.dart';
import 'package:golf_swing_analysis/screens/home_screen.dart';
import 'package:golf_swing_analysis/theme/swingpath_theme.dart';
import 'package:golf_swing_analysis/widgets/swingpath_bottom_nav.dart';
import 'package:golf_swing_analysis/widgets/tab_slide_switcher.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  static const _tabs = <Widget>[
    HomeScreen(),
    DrillsScreen(),
    _PlaceholderTab(title: 'Record', icon: Icons.videocam_rounded),
    ProgressScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SwingPathColors.background,
      body: TabSlideSwitcher(
        index: _selectedIndex,
        children: _tabs,
      ),
      bottomNavigationBar: SwingPathBottomNav(
        selectedIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: SwingPathColors.textMuted),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Coming soon',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
