import 'package:flutter/material.dart';
import 'package:indihood/src/route/custom_material_page_route.dart';
import 'package:indihood/src/ui/home/screens/loan_details_screen.dart';
import 'package:indihood/src/ui/home/screens/loan_lists_screen.dart';

class Routes {
  static onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoanListsScreen.ROUTE_NAME:
        return _navigate(LoanListsScreen(), settings);
      case SchemaDetailsScreen.ROUTE_NAME:
        return _navigate(SchemaDetailsScreen(), settings);
    }
    return null;
  }
}

_navigate(Widget child, RouteSettings settings) {
  return CustomMaterialPageRoute(
      settings: settings,
      builder: (context) {
        return child;
      });
}
