library services;

import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart' as getx;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vms_client_flutter/app/model/resp_model.dart';
import 'package:vms_client_flutter/app/modules/login/index.dart';
import 'package:vms_client_flutter/const/common.dart';
import 'package:vms_client_flutter/store/index.dart';

part 'http.dart';
part 'storage.dart';
