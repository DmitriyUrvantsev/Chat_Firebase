import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chat_firebase/data/models/user/user_app.dart';
import 'package:chat_firebase/firebase_options.dart';
import 'package:chat_firebase/presentation/auth_screen/provider/maim_screen_provider.dart';
import 'package:chat_firebase/servises/auth_servises.dart';
import 'core/app_export.dart';
import 'presentation/chat_screen/provider/chat_provider.dart';

///

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Future.wait([
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]),
    PrefUtils().init()
  ]).then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => ThemeProvider()),
            ChangeNotifierProvider(create: (context) => MainScreenProvider()),
            ChangeNotifierProvider(create: (context) => ChatScreenProvider()),
            StreamProvider<UserApp?>.value(
              value: AuthService().user,
              initialData: null,
            ),
          ],
          child: Consumer<ThemeProvider>(
            builder: (context, provider, child) {
              return MaterialApp(
                theme: theme,
                title: 'chat_firebase',
                navigatorKey: NavigatorService.navigatorKey,
                debugShowCheckedModeBanner: false,
                initialRoute: MainNavigation().initialRoute,
                routes: MainNavigation().routes,
              );
            },
          ),
        );
      },
    );
  }
}
