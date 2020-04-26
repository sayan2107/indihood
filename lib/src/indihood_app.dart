import 'package:indihood/src/ui/home/screens/loan_details_screen.dart';
import 'package:indihood/src/ui/home/screens/loan_lists_screen.dart';
import 'package:indihood/src/utility/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:indihood/src/routes.dart';
import 'package:indihood/generated/i18n.dart';

class IndihoodApp extends StatefulWidget {
  static const locale = [Locale("en", "")];

  static void setLocale(BuildContext context, Locale newLocale) async {
    _IndihoodAppState state =
        context.ancestorStateOfType(TypeMatcher<_IndihoodAppState>());

    state.setState(() {
      state.locale = newLocale;
    });
  }

  @override
  _IndihoodAppState createState() => _IndihoodAppState();
}

class _IndihoodAppState extends State<IndihoodApp> {
  var locale = IndihoodApp.locale[0];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor: ColorConstants.home_bg_gradient_color2,
          fontFamily: 'Poppins'),
      localizationsDelegates: [
        S.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      locale: locale,
      supportedLocales: S.delegate.supportedLocales,
      localeResolutionCallback: S.delegate.resolution(fallback: locale),
      home: LoanListsScreen(),
      onGenerateRoute: (RouteSettings settings) {
        return Routes.onGenerateRoute(settings);
      },
    );
  }
}
