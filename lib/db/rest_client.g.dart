// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://sparkar-token-crawler.netlify.app/.netlify/functions/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<dynamic> getCookiesWithEncryptedLoginData(encpass, lsd, email) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'encpass': encpass,
      r'lsd': lsd,
      r'email': email
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<dynamic>(
        Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, '/facebook_get_cookie',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<dynamic> getUsersAndEffectWithCookie(cookie) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'cookie': cookie.toJson()};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<dynamic>(
        Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, '/facebook_get_users_and_effects',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<dynamic> getPublicKeys() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<dynamic>(
        Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, '/facebook_public_keys',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<dynamic> facebookRequest(body, cookie) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
            method: 'POST',
            headers: <String, dynamic>{
              r'authority': ' www.facebook.com',
              r'accept': ' */*',
              r'accept-language': ' en-US,en;q=0.9,it;q=0.8',
              r'content-type': 'application/x-www-form-urlencoded',
              r'origin': ' https://www.facebook.com',
              r'referer': ' https://www.facebook.com/sparkarhub/effects/',
              r'sec-fetch-dest': ' empty',
              r'sec-fetch-mode': ' cors',
              r'sec-fetch-site': ' same-origin',
              r'user-agent':
                  ' Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.183 Safari/537.36',
              r'cookie': cookie
            },
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded')
        .compose(_dio.options, 'https://www.facebook.com/api/graphql/',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
