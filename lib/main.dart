import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:inventmarket_app/src/pages/home_page.dart';
import 'package:inventmarket_app/src/pages/login_page.dart';
import 'package:inventmarket_app/src/pages/sing_up_page.dart';
import 'package:inventmarket_app/src/providers/main_provider.dart';
import 'package:inventmarket_app/src/theme/main_theme.dart';
//import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: true);
    return FutureBuilder<bool>(
        future: mainProvider.getPreferences(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ScreenUtilInit(
                designSize: const Size(360, 690),
                builder: () => MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'InventMarket',
                    theme: AppTheme.themeData(mainProvider.mode),
                    //home: const HomePage()));
                    routes: {
                      "/singUp": (context) => const SingUpPage()
                    },
                    home: const LoginPage()
                    /*home: mainProvider.token == ""
                        ? const LoginPage()
                        : JwtDecoder.isExpired(mainProvider.token)
                            ? const LoginPage()
                            : const HomePage()*/
                  )
                );
          }
          return const SizedBox.square(
              dimension: 100.0, child: CircularProgressIndicator());
        });
  }
}
