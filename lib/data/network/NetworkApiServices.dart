import 'dart:convert';
import 'dart:io';

import 'package:mvvm_provider/data/app_exception.dart';
import 'package:mvvm_provider/data/network/BaseApiServices.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJSon;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
      //save data to resjson var
      responseJSon = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJSon;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJSon;
    try {
      http.Response response = await http
          .post(
            Uri.parse(url),
            body: data,
          )
          .timeout(Duration(seconds: 10));
      //save data to resjson var
      responseJSon = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJSon;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      case 400:
        throw BadRequestException(response.body.toString());

      case 404:
        throw UnauthorizedException(response.body.toString());

      default:
        throw FetchDataException(
            'Error come while fetching data ! with status code ' +
                response.statusCode.toString());
    }
  }
}
