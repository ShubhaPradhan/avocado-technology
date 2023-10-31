import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../config/api_end_point.dart';

class ApiClient {
  Future<ApiResponse<T>> getApi<T>(
    String endPoint, {
    T Function(dynamic json)? fromJson,
  }) async {
    log("IN API CLIENT");
    var header = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    try {
      log("Trying");
      final response = await http.get(Uri.parse(ApiUrls.baseUrl + endPoint),
          headers: header);
      log("Url: ${ApiUrls.baseUrl + endPoint}");
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        log("Decoded");
        final data = fromJson != null ? fromJson(json) : json as T;
        log("Data: $data");
        return ApiResponse.completed(data);
      } else {
        final message = jsonDecode(response.body)['message'].toString();
        return ApiResponse.error(message);
      }
    } on SocketException {
      return ApiResponse.error("No Internet Connection");
    } catch (e) {
      return ApiResponse.error("Something went wrong. Please try again later");
    }
  }
}

class ApiResponse<T> {
  ApiStatus? status;
  T? response;
  String? message;

  ApiResponse.initial([this.message])
      : status = ApiStatus.INITIAL,
        response = null;

  ApiResponse.loading([this.message])
      : status = ApiStatus.LOADING,
        response = null;

  ApiResponse.completed(this.response)
      : status = ApiStatus.SUCCESS,
        message = null;

  ApiResponse.error(this.message)
      : status = ApiStatus.ERROR,
        response = null;

  @override
  String toString() {
    return "Status: $status \n Message: $message \n Response: $response";
  }
}

class ApiMessage {
  String getMessage(int statusCode) {
    switch (statusCode) {
      case 200:
        return "Success";
      case 400:
        return "Bad Request";
      case 401:
        return "Unauthorized";
      case 403:
        return "Forbidden";
      case 404:
        return "Not Found";
      case 500:
        return "Internal Server Error";
      default:
        return "Oops! Something went wrong. Error code: $statusCode";
    }
  }
}

enum ApiStatus {
  INITIAL,
  LOADING,
  SUCCESS,
  ERROR,
}
