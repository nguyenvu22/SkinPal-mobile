import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:get/get.dart';
import 'package:skinpal/environment/environment.dart';
import 'package:skinpal/models/response_api.dart';
import 'package:skinpal/models/user.dart';
import 'package:http/http.dart' as http;

class UsersProvider extends GetConnect {
  String url = "${Environment.GETX_API_URL}api/users";

  Future<ResponseApi> regist(User user) async {
    Response response = await post(
      "$url/registration",
      user.toJson(),
      headers: {
        "Content-Type": "application/json",
      },
    );
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  //Work well only simple size file but not heavy one
  Future<ResponseApi> registWithImg(User user, File image) async {
    FormData form = FormData({
      'image': MultipartFile(
        image,
        filename: basename(image.path),
      ),
      'user': json.encode(user), //convert to JSON
    });

    //Send user and image separately using <form>
    Response response = await post(
      "$url/registrationWithImg",
      form,
      headers: {
        "Content-Type": "application/json",
      },
    );
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  Future<Stream> registWithImgPlus(User user, File image) async {
    Uri uri = Uri.http(
      Environment.HTTP_API_URL,
      '/api/users/registrationWithImg',
    );
    final request = http.MultipartRequest('POST', uri);
    request.files.add(
      http.MultipartFile(
        'image',
        http.ByteStream(image.openRead().cast()),
        await image.length(),
        filename: basename(image.path),
      ),
    );
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  Future<ResponseApi> login(String email, String password) async {
    Response response = await post(
      '$url/login',
      {
        'email': email,
        'password': password,
      },
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.body == null) {}
    // print('Response : ${response.statusCode}');
    // print('Response : ${response.body}');

    // Object that fit to the response that be return (success-message-data)
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    // print('ResponseApi : ${responseApi.data}');
    // print('ResponseApi : ${responseApi.message}');
    // print('ResponseApi : ${responseApi.success}');

    return responseApi;
  }

  Future<ResponseApi> update(User user) async {
    Response response = await put(
      "$url/modification",
      user.toJson(),
      headers: {
        "Content-Type": "application/json",
      },
    );
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  Future<Stream> updateWithImg(User user, File image) async {
    Uri uri = Uri.http(
      Environment.HTTP_API_URL,
      '/api/users/modificationWithImg',
    );
    final request = http.MultipartRequest('PUT', uri);
    request.files.add(
      http.MultipartFile(
        'image',
        http.ByteStream(image.openRead().cast()),
        await image.length(),
        filename: basename(image.path),
      ),
    );
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }
}
