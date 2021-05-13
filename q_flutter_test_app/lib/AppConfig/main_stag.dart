import 'package:flutter/material.dart';

import '../ui/home/home.dart';
import 'app_config.dart';



void  main () {
  var configuredApp =  new  AppConfig (
    appName: 'Q Flutter Testing App STAGING',
    flavorName: 'development',
    apiBaseUrl: 'https://jsonplaceholder.typicode.com/comments',
    child: Home(),
  );

  runApp(configuredApp);
}