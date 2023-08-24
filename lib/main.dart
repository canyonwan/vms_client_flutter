import 'package:flutter/material.dart';
import 'package:vms_client_flutter/app.dart';

import 'global.dart';

void main() {
  Global.init().then((_) => runApp(const App()));
}
