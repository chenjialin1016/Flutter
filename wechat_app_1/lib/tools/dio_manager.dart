import 'package:dio/dio.dart';

class DioManager {
//  单例创建dio
  static final DioManager _share = DioManager._init();
  static Dio _dio;

  factory DioManager() => _share;

  DioManager._init() {
    _dio = _defaultDio();
  }

  static Dio _defaultDio() {
    if (_dio == null) {
      _dio = Dio(_defaultOptions());
    }
    return _dio;
  }

//    设置默认配置
  static BaseOptions _defaultOptions() {
    return BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    );
  }

//    get

  static get(String url, {options, Function success, Function failure}) async {
    try {
      Response response = await _defaultDio().get(url, options: options);
      success(response.data);
    } catch (error) {
      failure(error);
    }
  }

//    post
  static post(String url, {params, options, Function success, Function failure}) async {
    try {
      Response response = await _defaultDio().post(url, data: params, options: options);
      success(response.data);
    } catch (error) {
      failure(error);
    }
  }
}
