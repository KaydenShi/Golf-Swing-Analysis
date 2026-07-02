import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:golf_swing_analysis/screens/main_shell.dart';
import 'package:golf_swing_analysis/theme/swingpath_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: SwingPathColors.surface,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const SwingPathApp());
}

class SwingPathApp extends StatelessWidget {
  const SwingPathApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SwingPath',
      debugShowCheckedModeBanner: false,
      theme: buildSwingPathTheme(),
      home: const MainShell(),
    );
  }
}
