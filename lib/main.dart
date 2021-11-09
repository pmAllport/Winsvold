import 'package:flutter/material.dart';
import 'package:winsvold/views/OCRView/ocr.dart';
import 'package:winsvold/views/ProductView/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winsvold/blocs/simple_bloc_observer.dart';
import 'package:winsvold/blocs/vinmonopolet/product_bucket.dart';
import 'package:winsvold/data/product_repository.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:winsvold/views/ProductView/product_list.dart';
import 'package:winsvold/views/routes.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = const ColorScheme(
        primary: Color(0xff296459),
        primaryVariant: Color(0xFF002025),
        secondary: Color(0xfff4f4f5),
        secondaryVariant: Color(0xff002025),
        surface: Color(0xFF002025),
        background: Color(0xFFfefefe),
        error: Color(0xFF6C2025),
        onPrimary: Color(0xFFfefefe),
        onSecondary: Color(0xFFfefefe),
        onSurface: Color(0xFFfefefe),
        onBackground: Color(0xFFdcf2eb),
        onError: Color(0xFF6C2025),
        brightness: Brightness.light);

    return MaterialApp(
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              settings: settings,
              builder: (BuildContext context) {
                switch (settings.name) {
                  case '/':
                    return OCRPage(
                      title: "OCR",
                    );
                  case ExtractProductList.routeName:
                    return const ExtractProductList();
                  case ExtractAmountList.routeName:
                    return const ExtractAmountList();
                  default:
                    return OCRPage(
                      title: "OCR",
                    );
                }
              });
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: colorScheme,
          textTheme: TextTheme(
            headline1: GoogleFonts.notoSans(
              fontSize: 95.0,
              fontWeight: FontWeight.normal,
              letterSpacing: -1.5,
              color: Colors.teal,
            ),
            headline2: GoogleFonts.notoSans(
              fontSize: 59.0,
              fontWeight: FontWeight.normal,
              letterSpacing: -0.5,
              color: Colors.teal,
            ),
            headline3: GoogleFonts.notoSans(
              fontSize: 48.0,
              fontWeight: FontWeight.normal,
              letterSpacing: 0.0,
              color: Colors.teal,
            ),
            headline4: GoogleFonts.notoSans(
              fontSize: 34.0,
              fontWeight: FontWeight.normal,
              letterSpacing: 0.25,
              color: Colors.teal,
            ),
            headline5: GoogleFonts.notoSans(
              fontSize: 24.0,
              fontWeight: FontWeight.normal,
              letterSpacing: 0.0,
              color: Colors.teal,
            ),
            headline6: GoogleFonts.notoSans(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.15,
              color: colorScheme.primary,
            ),
            subtitle1: GoogleFonts.notoSans(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              letterSpacing: 0.15,
              color: Colors.black,
            ),
            subtitle2: GoogleFonts.notoSans(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.10,
              color: Colors.black,
            ),
            bodyText1: GoogleFonts.notoSans(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              letterSpacing: 0.5,
              color: Colors.white,
            ),
            bodyText2: GoogleFonts.notoSans(
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
              letterSpacing: 0.25,
            ),
            button: GoogleFonts.notoSans(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.25,
              color: Colors.white,
            ),
            caption: GoogleFonts.notoSans(
              fontSize: 12.0,
              fontWeight: FontWeight.normal,
              letterSpacing: 0.40,
            ),
            overline: GoogleFonts.notoSans(
              fontSize: 10,
              fontWeight: FontWeight.normal,
              letterSpacing: 1.5,
            ),
          ),
        ),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        home: OCRPage(title: "OCR"));
  }
}
