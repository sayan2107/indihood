import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:indihood/src/indihood_app.dart';
import 'package:indihood/src/data/shared_pref.dart';
import 'package:indihood/src/data/web_services.dart';
import 'package:indihood/src/infra/network/web_services_impl.dart';
import 'package:indihood/src/infra/sharedpreference_helper.dart';
import 'package:indihood/src/indihood_app.dart';
import 'package:indihood/src/utility/url_constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  setUpDependencyInjection();

  runApp(IndihoodApp());
}

void setUpDependencyInjection() {
  GetIt.instance.registerLazySingleton<SharedPrefData>(() => SharedPrefsImpl());
  GetIt.instance.registerLazySingleton<WebServices>(() => WebServicesImpl(UrlConstants.BASE_URL));
}
