import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:uqido_sparkar/db/abstract_db.dart';
import 'package:uqido_sparkar/db/rest_client.dart';
import 'package:uqido_sparkar/model/sparkar_effect.dart';
import 'package:uqido_sparkar/model/sparkar_user.dart';
import 'package:uqido_sparkar/utils/facebook_password_encrypt_util.dart';

class SparkARDB with DBCache implements AbstractDB {
  static final SparkARDB _instance = SparkARDB._internal();

  static final RestClient client = RestClient(Dio());

  SparkARDB._internal();

  factory SparkARDB.getInstance() {
    return _instance;
  }

  @override
  Future<List<SparkARUser>?> getAllUsers(
      {String? email, EncryptedLoginData? loginData}) async {
    //if (email != null && loginData != null) {
    //  //i must delete login data from cache
    //  cache.destroy('spark-ar-user-cookie');
    //  cache.destroy('spark-ar-users-netlify');
    //}
    //get actual facebook public keys from netlify function

    try {
      var tokenCookie = (await checkCache<Map<String, dynamic>>(
              'spark-ar-user-cookie', () async {
        if (loginData == null) return [];
        final encpass = loginData.encpass;
        final lsd = loginData.lsd;
        print(encpass);
        var cookies =
            await client.getCookiesWithEncryptedLoginData(encpass, lsd, email!);

        print(cookies);
        return [cookies as Map<String, dynamic>];
      }, customCacheDuration: Duration(days: 3)))
          .first;

      print(tokenCookie);
      try {
        var data = await checkCache<Map<String, dynamic>>(
            'spark-ar-users-netlify', () async {
          if (kIsWeb) {
            return await getUsersAndEffectsByNetlify(tokenCookie['cookie']);
          } else {
            return await getUsersAndEffectsByRequest(
                tokenCookie['cookie'], tokenCookie['token']);
          }
        });

        //print(data);

        return List.unmodifiable(data.map((e) => SparkARUser.fromJson(e)));
      } catch (e) {
        print(e);
        rethrow;
        //return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getUsersAndEffectsByNetlify(
      String cookie) async {
    final response = await client.getUsersAndEffectWithCookie(cookie);

    //print("Print data");
    //print(response.data);
    //final data = jsonDecode(response.data) as List<dynamic>;
    final data = response['data'] as List<dynamic>;
    //final cookie = response.data['cookie'] as List<dynamic>;
    //print(data);
    var list = data.map((e) => e as Map<String, dynamic>).toList();
    //print(list);
    return list;
  }

  Future<List<Map<String, dynamic>>> getUsersAndEffectsByRequest(
      String cookie, String token) async {
    print("getUsersAndEffectsByRequest");
    print(cookie);
    print(token);
    var body = {'doc_id': '', 'variables': '{}', 'fb_dtsg': '', '__a': 1};
    body['doc_id'] = '2737348616365573';
    body['variables'] = '{}';
    body['fb_dtsg'] = token;

    final baseCookies =
        "spin=r.1003566664_b.trunk_t.1617572245_s.1_v.2_; wd=629x947;datr=ATBqYAPPqxHp61lxJHX3QhBF;";

    final cookies = baseCookies + cookie;

    final effectQuery = await client.facebookRequest(body, cookies);

    print(effectQuery);

    var parsed = jsonDecode(effectQuery);

    var owners = parsed['data']['ar_hub_effects_query']['ar_hub_settings']
        ['owners'] as List<dynamic>;

    print(owners);
    var users = owners.map((item) {
      return SparkARUser(item['owner']['id'], item['owner']['name'],
          item['owner']['profile_picture']['uri'], []);
    }).toList();

    final usersAndEffects = await getEffectsForUsers(users, cookie, token);

    return usersAndEffects.map((e) => e.toJson()).toList();
  }

  Future<List<SparkARUser>> getEffectsForUsers(
      List<SparkARUser> usersList, cookie, token) async {
    final usersAndEffects = List<SparkARUser>.empty(growable: true);

    var body = {'doc_id': '', 'variables': '{}', 'fb_dtsg': '', '__a': 1};
    body['doc_id'] = '3625110550842914';
    body['variables'] = '{}';
    body['fb_dtsg'] = token;

    final baseCookies =
        "spin=r.1003566664_b.trunk_t.1617572245_s.1_v.2_; wd=629x947;datr=ATBqYAPPqxHp61lxJHX3QhBF;";

    final cookies = baseCookies + cookie;

    for (final user in usersList) {
      final variables =
          '{"selectedOwnerID":"${user.id}","filters":{"effect_name_contains_ci":"","visibility_statuses":[],"review_statuses":[],"surfaces":[],"exclude_surfaces":["AR_ADS"]},"orderby":["LAST_MODIFIED_TIME_DESC"]}';
      body['variables'] = variables;

      final effectQuery = await client.facebookRequest(body, cookies);

      print("EFFECTSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
      var parsed = jsonDecode(effectQuery);
      print(parsed);
      final effects =
          parsed['data']['ar_hub_effects_query']['owner']['effects'];
      print(effects);
      if (effects == null) continue;

      final edges = effects['edges'] as List<dynamic>;

      final effectsForUser = edges.map((effect) {
        final studioEffect = effect['node']['ar_studio_effect'];
        var isDeprecated = false;
        if (studioEffect['submission_status'] != 'NOT_REVIEWED' &&
            studioEffect['submission_status'] != 'NOT_APPROVED') {
          isDeprecated =
              studioEffect['latest_active_arexport_file']['is_deprecated'];
        }
        return SparkAREffect(
          effect['node']['id'],
          studioEffect['name'],
          studioEffect['submission_status'],
          studioEffect['visibility_status'],
          isDeprecated,
          studioEffect['test_link'],
          studioEffect['share_link'],
          studioEffect['thumbnail_uri'],
        );
      }).toList();
      if (effectsForUser.length != 0) {
        usersAndEffects.add(user.copyWith(effects: effectsForUser));
      }
    }
    return usersAndEffects;
  }
}
