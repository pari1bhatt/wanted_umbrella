import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wanted_umbrella/pages/explore/selection_swipte_provider.dart';
import 'package:wanted_umbrella/pages/on_boarding/on_boarding_provider.dart';
import 'package:wanted_umbrella/routes.dart';
import 'package:wanted_umbrella/utils/constants.dart';
import 'package:wanted_umbrella/utils/themes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: OnBoardingProvider()),
        ChangeNotifierProvider.value(value: ExplorePageProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: GetStrings.appName,
        theme: MyTheme.lightTheme(),
        darkTheme: MyTheme.darkTheme(),
        onGenerateRoute: Routes.generateRoute,
        initialRoute: Routes.login,
        // theme: ThemeData(primarySwatch: Colors.blue),
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

