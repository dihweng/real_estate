// ignore_for_file: overridden_fields
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../utils/env_config.dart';
import '../utils/local_store.dart';
import '../viewmodels/base_model.dart';

class ApiService extends BaseViewModel {
  late Dio client;
  // final AuthState _authStateCtrl = locator<AuthState>();

  @override
  String? errorMessage;

  final ViewStatus _status = ViewStatus.Success;

  @override
  ViewStatus get viewStatus => _status;

  ApiService() {
    client = Dio();
    client.options.baseUrl = EnvConfig.baseUrl;
    client.options.sendTimeout = EnvConfig.timeout;
    client.options.connectTimeout = EnvConfig.timeout;
    client.options.receiveTimeout = EnvConfig.receiveTimeout;
    client.options.headers['Accept'] = 'application/json';
    client.options.headers['Content-Type'] = 'application/json';
  }


  void setToken(String authToken) {
    client.options.headers['Authorization'] = 'Bearer $authToken';
  }

  Future<void> clientSetup() async {


    final String authToken = await LocalStoreHelper.getUserToken();
    if (authToken.isNotEmpty) {
      client.options.headers['Authorization'] = 'Bearer $authToken';
    }

    client.interceptors.add(
      PrettyDioLogger(
        responseBody: true,
        requestBody: true,
      ),
    );

    client.interceptors.add(
      QueuedInterceptorsWrapper(onError: (
        DioException e,
        errorInterceptorHandler,
      ) async {
        if (e.type == DioExceptionType.connectionTimeout) {
          // 'Error(connecting, check your internet and try again.');
        }
        if (e.response?.statusCode == 401) {
          await LocalStoreHelper.removeUserToken();
          client.options.headers['Authorization'] = null;
          // _authStateCtrl.logOut();
        }
        return errorInterceptorHandler.reject(e);
      }),
    );
  }
}