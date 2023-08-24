part of services;

class HttpService extends getx.GetxService {
  static HttpService get to => getx.Get.find();

  late final Dio _dio;

  @override
  void onInit() {
    super.onInit();
    bool isRelease = const bool.fromEnvironment('dart.vm.product');

    final options = BaseOptions(
      baseUrl: kProdApiUrl,
      // baseUrl: isRelease ? kProdApiUrl : kDevApiUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {},
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      followRedirects: false,
    );

    _dio = Dio(options);

    _dio.interceptors.add(_RequestInterceptors());

    // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验 - 如果不需要，就在proxy.dart 文件中将PROXY_ENABLE设置成false，重新运行即可。

    const proxyEnable = false;
    // 代理服务IP - 请查看自己的网卡对应的IP地址
    const proxyIp = '192.168.3.63';
    // 代理服务端口 - 请查看你自己的抓包工具提供的端口
    const proxyPort = 9090;

    // ignore: dead_code
    if (!isRelease && proxyEnable) {
      (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return 'PROXY $proxyIp:$proxyPort';
        };
        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return null;
      };
    }
  }

  Map<String, dynamic>? _getHeaders({bool excludeToken = false}) {
    final headers = <String, dynamic>{};
    if (UserStore.to.hasToken && !excludeToken) {
      headers['Authorization'] = 'Bearer ${UserStore.to.token}';
    }
    return headers;
  }

  Future<ResponseModel> get(
    String url, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    bool excludeToken = false,
    bool showLoading = false,
  }) async {
    if (showLoading) SmartDialog.showLoading();
    try {
      final requestOptions = options ?? Options();
      // requestOptions.headers = _getHeaders(excludeToken: excludeToken);
      final response = await _dio.get(
        url,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken,
      );
      if (showLoading) SmartDialog.dismiss();
      return ResponseModel.fromJson(response.data);
      // return response.data;
    } catch (error) {
      if (error is DioError) SmartDialog.dismiss();
      rethrow;
    }
  }

  Future<Map<String, dynamic>> post(
    String url, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? queries,
    Options? options,
    CancelToken? cancelToken,
    bool excludeToken = false,
    bool showLoading = false,
  }) async {
    if (showLoading) SmartDialog.showLoading();
    try {
      final requestOptions = options ?? Options();
      // requestOptions.headers = _getHeaders(excludeToken: excludeToken);
      final response = await _dio.post(
        url,
        data: params,
        queryParameters: queries,
        options: requestOptions,
        cancelToken: cancelToken,
      );
      if (showLoading) SmartDialog.dismiss();
      return response.data;
    } catch (error) {
      if (error is! DioError) SmartDialog.dismiss();
      rethrow;
    }
  }

  Future<Map<String, dynamic>> upload(
    String url, {
    required String path,
    Options? options,
    CancelToken? cancelToken,
    bool excludeToken = false,
  }) async {
    final requestOptions = options ?? Options();
    // requestOptions.headers = _getHeaders(excludeToken: excludeToken);
    final name = path.substring(path.lastIndexOf('/') + 1, path.length);
    final image = await MultipartFile.fromFile(path, filename: name);
    final formData = FormData.fromMap({'file': image});
    final response = await _dio.post(
      url,
      data: formData,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    // return ResponseModel.fromJson(response.data);
    return response.data;
  }

  Future<void> download(
    String url,
    String path, {
    CancelToken? cancelToken,
    bool excludeToken = false,
    bool showLoading = false,
  }) async {
    if (showLoading) SmartDialog.showLoading();
    try {
      await Dio().download(
        url,
        path,
        cancelToken: cancelToken,
        onReceiveProgress: (int count, int total) {},
      );
      if (showLoading) SmartDialog.dismiss();
    } catch (error) {
      if (error is! DioError) SmartDialog.dismiss();
      rethrow;
    }
  }
}

class _RequestInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions requestOptions, RequestInterceptorHandler handler) {
    if (UserStore.to.hasToken) {
      requestOptions.headers['Authorization'] = 'Bearer ${UserStore.to.token}';
    }
    super.onRequest(requestOptions, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data['code'] != 200) {
      handler.reject(
        DioError(
          requestOptions: response.requestOptions,
          response: response,
          type: DioErrorType.badResponse,
        ),
        true,
      );
    } else {
      super.onResponse(response, handler);
    }
  }

  /// 退出并重新登录
  Future<void> _errorNoAuthLogout() async {
    /// 添加登录过期的校验，防止反复跳转到登录页
    if (UserStore.to.isLogin) {
      await UserStore.to.logout();
      getx.Get.offAll(() => const LoginView());
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioErrorType.connectionTimeout:
        SmartDialog.showToast('网络连接超时');
        break;
      case DioErrorType.sendTimeout:
        SmartDialog.showToast('发送超时');
        break;
      case DioErrorType.receiveTimeout:
        SmartDialog.showToast('接收超时');
        break;
      case DioErrorType.badCertificate:
        SmartDialog.showToast('证书错误');
        break;
      case DioErrorType.badResponse:
        final response = err.response;
        final statusCode = response?.statusCode;
        var msg = '服务器错误';
        switch (statusCode) {
          case 302:
            msg = '$statusCode - Moved temporarily';
            _errorNoAuthLogout();
            break;
          case 404:
            msg = '$statusCode - Server not found';
            break;
          case 500:
            msg = '$statusCode - Server error';
            break;
          case 502:
            msg = '$statusCode - Bad gateway';
            break;
          default:
            /*if (response?.data['code'] == -6) {
            UserStore.to.logout();
            }*/
            msg = response?.data['message']?.toString() ?? msg;
            break;
        }
        SmartDialog.showToast(msg);
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.connectionError:
        SmartDialog.showToast('网络连接失败');
        break;
      case DioErrorType.unknown:
        SmartDialog.showToast('请求发生未知错误');
        break;
    }
    super.onError(err, handler);
  }
}
