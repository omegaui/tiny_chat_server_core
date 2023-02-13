
import 'dart:convert';
import 'dart:io';

import '../internal/server.dart';

dynamic configuration;

void loadConfig(){
  configuration = jsonDecode(File(serverConfigPath).readAsStringSync());
}
