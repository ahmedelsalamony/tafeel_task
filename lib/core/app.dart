import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tafeel_task/app_features/users/presentation/screens/users_screen.dart';
import 'package:tafeel_task/core/app_router/app_router.dart';
import 'package:tafeel_task/core/app_router/routes.dart';
import 'package:tafeel_task/core/themes/color.dart';

// Import other cubits as needed

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(375, 812),
      child: MaterialApp(
        onGenerateRoute: AppRouter.generateRoute,
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.users,
        theme: ThemeData(
          primaryColor: ColorsManager.mainBlue,
          scaffoldBackgroundColor: Colors.white,
        ),
        title: "Tafeel Task",
      ),
    );
  }
}
