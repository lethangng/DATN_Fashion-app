import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../exceptions/app_exceptions.dart';
import 'base_api_service.dart';

final Map<String, String> baseHeader = {
  HttpHeaders.authorizationHeader: '',
  HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
};

class ApiService extends BaseApiService {
  @override
  Future getResponse(String url) async {
    dynamic responseJson;
    try {
      debugPrint(baseUrl + url);
      final response = await http.get(
        Uri.parse(baseUrl + url),
        // headers: baseHeader,
      )
          // .timeout(
          //   const Duration(seconds: 20),
          // )
          ;
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on RequestTimeOut {
      throw RequestTimeOut('Request Timeout');
    }
    return responseJson;
  }

  @override
  Future postResponse({
    required String url,
    required Object bodyData,
  }) async {
    try {
      dynamic responseJson;
      final response = await http.post(
        // Uri.parse(url),
        Uri.parse(baseUrl + url),
        // headers: baseHeader,
        // body: json.encode(jsonBody),
        body: bodyData,
      );
      responseJson = returnResponse(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on RequestTimeOut {
      throw RequestTimeOut('Request Timeout');
    }
  }

  @override
  Future uploadFileResponse({
    required String url,
    required Map<String, String> bodyData,
    required File file,
  }) async {
    // dynamic responseJson;
    try {
      final request = http.MultipartRequest('POST', Uri.parse(baseUrl + url));

      request.fields.addAll(bodyData);

      // request.fields['app_id'] = uploadFileModel.requestData.app_id;
      // request.fields['token_login'] = uploadFileModel.requestData.token_login;
      // request.fields['query'] = uploadFileModel.requestData.query;
      // request.fields['user_id'] = uploadFileModel.requestData.user_id;
      // request.fields['data'] = uploadFileModel.requestData.data;

      request.files.add(await http.MultipartFile.fromPath(
        'file',
        file.path,
        contentType: MediaType.parse("image/*"),
      ));

      final response = await request.send();
      if (response.statusCode == 200) {
        var responseString = await response.stream.toBytes();
        dynamic responseJson = String.fromCharCodes(responseString);
        return jsonDecode(responseJson);
      } else {
        debugPrint('Lỗi có status code : ${response.statusCode}');
        throw FetchDataException('Lỗi khi liên lạc với máy chủ.');
      }
      // responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    // on RequestTimeOut {
    //   throw RequestTimeOut('Request Timeout');
    // }
    // return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      default:
        // Loi 404:
        debugPrint('Lỗi có status code : ${response.statusCode}');
        throw FetchDataException('Lỗi khi liên lạc với máy chủ.');
    }
  }
}
