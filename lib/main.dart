import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // 👈 لازم الاستيراد ده
import 'package:sadeem_project/presentation/auth/view/login/login_screen.dart';
import 'package:sadeem_project/presentation/auth/view/login/register_screen.dart';
import 'package:sadeem_project/presentation/main_screen/view/MainScreen.dart';
import 'package:sadeem_project/presentation/tabs/home/view/home_screen.dart';
import 'package:sadeem_project/presentation/tabs/profile/view/profile_screen.dart';
import 'core/api/api_manager.dart';
import 'core/di/di.dart';
import 'core/observer/observer.dart';
import 'core/utils/routes_manager.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  //Bloc.observer = MyBlocObserver();
  ApiManager.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          routes: {
            RouteManager.homeScreen: (context) => HomeScreen(),
            RouteManager.mainScreen: (context) => MainScreen(),
              RouteManager.loginScreen: (context) => LoginScreen(),
            RouteManager.registerScreen: (context) => RegisterScreen(),
            RouteManager.profileScreen: (context) => ProfileScreen(),

          },
          initialRoute: RouteManager.loginScreen,
        );
      },
    );
  }
}
