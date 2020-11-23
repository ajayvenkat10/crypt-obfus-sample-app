import 'dart:io';

import 'package:encdec_obfus_sample_app/network_logger/cc_logger_constants.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

enum LoggerType { response, request }

class CcNetworkLogger {
  static bool loggerEnabled = true;

  static void logRequestDio(RequestOptions request,
      {LoggerType loggerType = LoggerType.request}) {
    ///TODO : Obtain loggerEnabled value from sdkBridge
    if (loggerEnabled) {
      final requestMethod = request?.method;
      final requestMethodIcon = CcLoggerConstants.httpMethodIcon[requestMethod];
      final url = request?.baseUrl + request?.path;
      final requestUrl = _logRequestUrl(url);
      final requestQueryParams = _logQueryParams(url);
      final requestBody = request?.data.toString();
      final headers = _logHeaders(request?.headers);

      print('${CcLoggerConstants.header} $requestMethodIcon => $requestMethod ($requestUrl) \nqueryParams: $requestQueryParams \nheaders: $headers \nbody : $requestBody ${CcLoggerConstants.footer}');
    }
  }

  static void logResponseDio(Response response,
      {LoggerType loggerType = LoggerType.response}) {
    ///TODO : Obtain loggerEnabled value from sdkBridge
    if (loggerEnabled) {
      final responseUrl = response.request.baseUrl + response.request.path;
      final statusCode = response.statusCode;
      final responseIcon =
          CcLoggerConstants.responseStatusIcon[statusCode ~/ 100];
      final responseString = CcLoggerConstants.responseStatusString[statusCode];
      final responseBody = response.data.toString();

      print('${CcLoggerConstants.header}$responseUrl ($responseIcon $statusCode : $responseString) \nbody : $responseBody ${CcLoggerConstants.footer}');
    }
  }

  static void logRequest(http.Request request,
      {LoggerType loggerType = LoggerType.request}) {
    // bool loggerEnabled = SdkBridge.isLoggerEnabled();
    if (loggerEnabled) {
      List<String> requestLogList = [];
      final requestMethod = request?.method;
      final requestMethodIcon = CcLoggerConstants.httpMethodIcon[requestMethod];
      final url = request?.url.toString();
      final requestUrl = _logRequestUrl(url);
      final requestQueryParams = _logQueryParams(url);
      final requestBody = request?.body;
      final headers = request?.headers.toString();
    }
  }

  static void logResponse(http.Response response,
      {LoggerType loggerType = LoggerType.response}) {
    if (loggerEnabled) {
      final responseUrl = response.request.toString();
      final statusCode = response.statusCode;
      final responseIcon =
          CcLoggerConstants.responseStatusIcon[statusCode ~/ 100];
      final responseString = CcLoggerConstants.responseStatusString[statusCode];
      final responseBody = response.body;
    }
  }

  static _logHeaders(Map<String, dynamic> headers) {
    var formattedHeaders = '{ \n';

    headers.forEach((key, value) {
      formattedHeaders += '\t$key : $value, \n';
    });

    formattedHeaders += '}\n';
    return formattedHeaders;
  }

  static _logRequestUrl(String url) {
    var uri = Uri.parse(url);
    return (uri.origin + uri.path);
  }

  static _logQueryParams(String url) {
    var queryParameters = '{ \n';

    var uri = Uri.parse(url);
    uri.queryParameters.forEach((key, value) {
      queryParameters += '\t$key : $value, \n';
    });

    queryParameters += '}\n';
    return queryParameters;
  }
}
