import 'package:cathnow/pages/snooze_page.dart';
import 'package:flutter/material.dart';
import 'package:cathnow/utils/color_schemes.g.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:cathnow/utils/settings.dart';
import 'package:cathnow/pages/log_cath.dart';
import 'package:cathnow/pages/privacy_page.dart';
import 'package:cathnow/pages/schedule_page.dart';
import 'package:cathnow/pages/settings_page.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Settings().loadSettingsFromLocal();
  await _requestpremission();
  runApp(ChangeNotifierProvider(
      create: (context) => Settings(),
      builder: ((context, child) => const CathNow())));
}

_requestpremission() async {
  var status = await Permission.notification.status;
  if (status.isGranted) {
  } else if (status.isDenied) {
    if (await Permission.notification.request() == PermissionStatus.granted) {
    } else if (await Permission.notification.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}

class CathNow extends StatelessWidget {
  const CathNow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CathNow',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      themeMode: (Provider.of<Settings>(context).darkMode)
          ? ThemeMode.dark
          : ThemeMode.light,
      home: const HomePage(),
      routes: <String, WidgetBuilder>{
        '/setup': (BuildContext context) => const SchedulePage(),
        '/settings': (BuildContext context) => const SettingsPage(),
        '/log': (BuildContext context) => const LogCathWidget(),
        '/privacy': (BuildContext context) => const PrivacyPolicyPage(),
        '/snooze': (BuildContext context) => const SnoozePage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return Consumer<Settings>(builder: (context, appState, _) {
      if (appState.haveList()) {
        return const LogCathWidget();
      } else {
        return const SchedulePage();
      }
    });
  }
}
