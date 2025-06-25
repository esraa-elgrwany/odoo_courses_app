import 'package:bloc/bloc.dart';
import 'package:courses_app/features/home/presentation/view/screens/add_task_screen.dart';
import 'package:courses_app/features/home/presentation/view/screens/home_screen.dart';
import 'package:courses_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:courses_app/features/setting/model_view/setting_cubit.dart';
import 'package:courses_app/features/setting/view/setting_screen.dart';
import 'package:courses_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/cache/shared_preferences.dart';
import 'core/utils/observer.dart';
import 'core/utils/styles/my_theme.dart';
import 'features/auth/presentation/view/login_screen.dart';
import 'features/home/presentation/view/screens/add_course_screen.dart';
import 'features/home/presentation/view/screens/course_details_screen.dart';
import 'features/home/presentation/view/screens/courses_screen.dart';
import 'features/home/presentation/view/screens/task_details_screen.dart';
import 'features/home/presentation/view/screens/tasks_screen.dart';
import 'features/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
   await CacheData.init();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MultiBlocProvider(
      providers: [
       BlocProvider(create:(context) => SettingCubit() ),
        BlocProvider(create: (context) => HomeCubit())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit,SettingState>(
  builder: (context, state) {
    return ScreenUtilInit(
        designSize: const Size(412, 870),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale(SettingCubit.get(context).languageCode),
          debugShowCheckedModeBanner: false,
          initialRoute:SplashScreen.routeName,
          routes: {
            SplashScreen.routeName: (context) => SplashScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
            HomeScreen.routeName:(context) => HomeScreen(),
            CourseScreen.routeName:(context) => CourseScreen(),
            TaskScreen.routeName:(context) => TaskScreen(),
            AddTaskScreen.routeName:(context) => AddTaskScreen(),
            AddCourseScreen.routeName:(context) => AddCourseScreen(),
            CourseDetailsScreen.routeName:(context) => CourseDetailsScreen(),
            TaskDetailsScreen.routeName:(context) => TaskDetailsScreen(),
            SettingScreen.routeName: (context) => SettingScreen(),
          },
          themeMode:ThemeMode.light,
          theme: MyThemeData.lightTheme,
        ));
  },
);
  }
}

