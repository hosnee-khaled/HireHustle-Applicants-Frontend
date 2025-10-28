import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Helpers/CacheHelper.dart';
import 'ThemeData/theme_data.dart';
import 'View/Screens/HomeNavigation/home_navigation.dart';
import 'View/Screens/main_screen.dart';
import 'ViewModel/StateManagement/HomeNavigation/navigation_cubit.dart';
import 'ViewModel/StateManagement/JobList/job_list_cubit.dart';
import 'ViewModel/StateManagement/Login/login_cubit.dart';
import 'ViewModel/StateManagement/Registration/registration_cubit.dart';
import 'ViewModel/StateManagement/Settings/Change Password/change_password_cubit.dart';
import 'ViewModel/StateManagement/Settings/DarkMode/dark_mode_cubit.dart';
import 'ViewModel/StateManagement/Settings/Notification/notification_screen_cubit.dart';
import 'ViewModel/StateManagement/Settings/Profile/profile_cubit.dart';
import 'ViewModel/StateManagement/Settings/settings_screen_cubit.dart';

void main() async {
  // Handle Flutter Binding Error.
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await CacheHelper.init();

  bool isLoggedIn;

  CacheHelper.getCachedData(key: 'hr') == null
      ? isLoggedIn = false
      : isLoggedIn = true;

  runApp(HireHustle(isLoggedIn));
}

class HireHustle extends StatelessWidget {
  HireHustle(this.isLoggedIn, {super.key});

  bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    // ));
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit()..initializeAll(),
        ),
        BlocProvider<RegistrationCubit>(
          create: (context) => RegistrationCubit(),
        ),
        BlocProvider<NavigationCubit>(
          create: (context) => NavigationCubit(),
        ),
        BlocProvider<SettingsScreenCubit>(
          create: (context) => SettingsScreenCubit(),
        ),
        BlocProvider<NotificationScreenCubit>(
          create: (context) => NotificationScreenCubit(),
        ),
        BlocProvider<DarkModeCubit>(
          create: (context) => DarkModeCubit()..initializeAll(),
        ),
        BlocProvider<ChangePasswordCubit>(
          create: (context) => ChangePasswordCubit(),
        ),
        BlocProvider<JobListCubit>(
          create: (context) => JobListCubit()..fetchAllValidJobPosts(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return BlocBuilder<DarkModeCubit, DarkModeState>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeDataLight(),
                home: isLoggedIn ? HomeNavigation() : MainScreen(),
                // home: HomeNavigation(),

              );
            },
          );
        },
      ),
    );
  }
}
