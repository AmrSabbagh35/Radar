// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:earthquake/features/auth/screens/login_screen.dart';
import 'package:earthquake/features/profile/services/profile_provider.dart';
import 'package:earthquake/features/tools/services/tools_provider.dart';
import 'package:earthquake/firebase_options.dart';
import 'package:earthquake/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/colors.dart';
import 'features/auth/services/auth_provider.dart';
import 'features/auth/services/location_provider.dart';
import 'features/home/services/home_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.getToken().then((token) {
    print('fcm token is : \n $token');
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => AuthProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => LocationProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => ProfileProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => HomeProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => ToolsProvider()),
        ),
      ],
      child: MaterialApp(
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [Locale('ar')],
          locale: const Locale('ar'),
          title: 'Radar',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: 'Taj',
              colorScheme: ColorScheme.light(primary: primary)),
          home: const CheckWidget()),
    );
  }
}

class CheckWidget extends StatefulWidget {
  const CheckWidget({super.key});

  @override
  _CheckWidgetState createState() => _CheckWidgetState();
}

class _CheckWidgetState extends State<CheckWidget> {
  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) => prefs.getBool('auth-token') == false ||
                  prefs.getBool('auth-token') == null
              ? const LoginScreen()
              : const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}
