import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'screens/onboarding_screen.dart';

void main() {
  runApp(const LFNannyApp());
}

class LFNannyApp extends StatelessWidget {
  const LFNannyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LFNanny',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blueMain),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
    );
  }
}
