import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'screens/dashboard/admin_dashboard.dart';
import 'constants/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Mess Sync',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: const AdminDashboard(), // Use your screen
        );
      },
    );
  }
}
