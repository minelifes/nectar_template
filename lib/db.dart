import 'package:nectar/nectar.dart';

final dbConfig = DbSettings(
  host: "0.0.0.0",
  // host: "10.25.0.23",
  port: 3306,
  // user: "root",
  user: "appuser",
  password: "apppassword",
  db: "dutify",
  debug: false, //change if you dont wanna see db debug
);