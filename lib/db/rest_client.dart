import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'rest_client.g.dart';

@RestApi(
    baseUrl: 'https://sparkar-data-extractor.netlify.app/.netlify/functions/')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/facebook_get_cookie")
  Future<dynamic> getCookiesWithEncryptedLoginData(
      @Query("encpass") String encpass,
      @Query("lsd") String lsd,
      @Query("email") String email);

  @GET("/facebook_get_users_and_effects")
  Future<dynamic> getUsersAndEffectWithCookie(@Query("cookie") cookie);

  @GET("/facebook_public_keys")
  Future<dynamic> getPublicKeys();

  @POST("https://www.facebook.com/api/graphql/")
  @Headers(<String, String>{
    'authority': ' www.facebook.com',
    'accept': ' */*',
    'accept-language': ' en-US,en;q=0.9,it;q=0.8',
    'content-type': 'application/x-www-form-urlencoded',
    'origin': ' https://www.facebook.com',
    'referer': ' https://www.facebook.com/sparkarhub/effects/',
    'sec-fetch-dest': ' empty',
    'sec-fetch-mode': ' cors',
    'sec-fetch-site': ' same-origin',
    'user-agent':
        ' Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.183 Safari/537.36'
  })
  Future<dynamic> facebookRequest(
      @Body() Map<String, dynamic> body, @Header('cookie') cookie);
}
