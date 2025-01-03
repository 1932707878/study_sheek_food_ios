import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:study_sheek_food_ios/api/dio_error_msg_model.dart';
import 'package:study_sheek_food_ios/api/dio_util.dart';
import 'package:study_sheek_food_ios/api/token_storage.dart';

var tokenStorage = TokenStorage();

/// 自定义拦截器
class CustomInterceptors extends Interceptor {
  /// 请求拦截
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);

    // http header 头加入 Authorization
    final token = tokenStorage.getAccessToken() as String;
    options.headers['Authorization'] = 'Bearer $token';

    return handler.next(options);
  }

  /// 响应拦截
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 200 请求成功
    if (response.statusCode != 200) {
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        ),
        true,
      );
    } else {
      // 提取Data
      response.data = response.data['data'];
      handler.next(response);
    }
  }

  // // 退出并重新登录
  // Future<void> _errorNoAuthLogout() async {
  //   await UserService.to.logout();
  //   IMService.to.logout();
  //   Get.toNamed(RouteNames.systemLogin);
  // }

  /// 错误拦截
  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    final exception = HttpException(err.message ?? "error message");
    switch (err.type) {
      case DioExceptionType.badResponse: // 服务端自定义错误体处理
        {
          final response = err.response;
          final errorMessage = ErrorMessageModel.fromJson(response?.data);
          switch (errorMessage.statusCode) {
            // 401 未登录
            case 401:
              // 刷新令牌校验
              _refreshToken(err, handler);
              // 注销 并跳转到登录页面
              // _errorNoAuthLogout();
              break;
            case 404:
              break;
            case 500:
              break;
            case 502:
              break;
            default:
              break;
          }
          // 显示错误信息
          // if(errorMessage.message != null){
          //   Loading.error(errorMessage.message);
          // }
        }
        break;
      case DioExceptionType.unknown:
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.connectionTimeout:
        break;
      default:
        break;
    }
    DioException errNext = err.copyWith(
      error: exception,
    );
    handler.next(errNext);
  }

  void _refreshToken(DioException err, ErrorInterceptorHandler handler) async {
    // 创建新Dio实例，避免循环引用
    final dio = Dio();
    // 刷新令牌地址
    const path = BASE_URL + '/refresh';
    try {
      String refreshToken = await tokenStorage.getRefreshToken();
      final resp = await dio.post(
        path,
        data: {'refreshToken': refreshToken},
      );
      log('Request Log: 更新令牌');
      // log('Request Log: ${resp.data.toString()}');
      // 更新访问令牌和刷新令牌
      final accessToken = resp.data['accessToken'] as String;
      tokenStorage.setToken(
          resp.data['accessToken'], resp.data['refreshToken']);
      // 重试原请求
      final opts = err.requestOptions;
      opts.headers['Authorization'] = 'Bearer $accessToken';
      final cloneReq = await dio.fetch(opts);
      return handler.resolve(cloneReq);
    } catch (e) {
      log('Request Error: 刷新令牌出错！');
      log(e.toString());
    }
  }
}
