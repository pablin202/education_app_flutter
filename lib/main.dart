import 'package:education_app_flutter/core/res/colors.dart';
import 'package:education_app_flutter/core/res/fonts.dart';
import 'package:education_app_flutter/core/services/injection_container.dart';
import 'package:education_app_flutter/core/services/router.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Education App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme:
            ColorScheme.fromSwatch(accentColor: AppColours.primaryColour),
        fontFamily: Fonts.poppins,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          color: Colors.transparent,
        ),
      ),
      onGenerateRoute: generateRoute,
    );
  }
}
