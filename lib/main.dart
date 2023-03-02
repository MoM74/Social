import 'package:fire_Social/layout/outfit_layout.dart';
import 'package:fire_Social/modules/login/login_screen.dart';
import 'package:fire_Social/shared/bloc_observer.dart';
import 'package:fire_Social/shared/components/constants.dart';
import 'package:fire_Social/shared/cubit/cubit.dart';
import 'package:fire_Social/shared/cubit/states.dart';
import 'package:fire_Social/shared/network/local/cache_helper.dart';
import 'package:fire_Social/shared/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/cubit/cubit.dart';
import 'package:fire_Social/modules/drawer/injection_container.dart' as di;

/*Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  debugPrint('on background message');
  debugPrint(message.data.toString());
  showToast(text: 'on background message', state: ToastStates.SUCCESS,);
}*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

//_____FirebaseMessaging_____________________________________________________
  /* var token = await FirebaseMessaging.instance.getToken();
  debugPrint(token);
// foreground fcm
  FirebaseMessaging.onMessage.listen((event)
  {
    debugPrint('on message');
    debugPrint(event.data.toString());
    showToast(text: 'on message', state: ToastStates.SUCCESS,);
  });
  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event)
  {
    debugPrint('on message opened app');
    debugPrint(event.data.toString());
    showToast(text: 'on message opened app', state: ToastStates.SUCCESS,);
  });
  // background fcm
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);*/
//____________________________________________________________________________

  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await di.init();

  Widget widget;
  var isDark = CacheHelper.getData(key: 'isDark');
  String uId = CacheHelper.getData(key: 'uId');
  if (uId != '') {
    widget = const SocialLayout();
  } else {
    widget = LoginScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  MyApp({
    required this.isDark,
    required this.startWidget,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
        BlocProvider(
            create: (BuildContext context) => SocialCubit()
              ..getUserData()
              ..getPosts()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
