import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

abstract class IPlatformClient {

  static IPlatformClient of(BuildContext context, {bool listen = false}) =>
      Provider.of<IPlatformClient>(context, listen: listen);

  http.Client get httpClient;
  Dio get dioClient;
  Dio get unauthenticatedDioClient;
  Future<Database> get dbSQL;
}