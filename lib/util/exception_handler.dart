import 'dart:io';

import 'package:dio/dio.dart';

class ExceptionHandler {
  static const KUnAuthorized = "Unauthorized request";
  static const kInvalidCredentials = "invalid Credentials";
  static String handleResponse2(int statusCode) {
    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        return "Unauthorized request";
        break;
      case 404:
        return "Not found";
        break;
      case 409:
        return "Error due to a conflict";
        break;
      case 408:
        return "Connection request timeout";
        break;
      case 500:
        return "Internal Server Error";
        break;
      case 503:
        return "Service unavailable";
        break;
      default:
        var responseCode = statusCode;
        return "Received invalid status code: $responseCode";
    }
  }

  static String handleException(error, {String? page}) {
    // print('handleException');
    String errorMessage = "Unexpected error occurred";

    if (error is DioError) {
      if (error.type == DioErrorType.cancel) {
        errorMessage = "Request Cancelled";
      } else if (error.type == DioErrorType.connectTimeout) {
        errorMessage = "Send timeout in connection with API server";
      } else if (error.type == DioErrorType.other) {
        errorMessage = "No internet connection";
      } else if (error.type == DioErrorType.receiveTimeout) {
        errorMessage = "Connection request timeout";
      } else if (error.type == DioErrorType.response) {
        errorMessage = handleResponse(error.response?.statusCode ?? 0);
      } else if (error.type == DioErrorType.sendTimeout) {
        errorMessage = "Connection request timeout";
      }
    } else if (error is SocketException) {
      errorMessage = "No internet connection";
    } else if (error is Exception) {
      errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
    }
    return errorMessage;
  }

  static String handleResponse(int statusCode) {
    String message = '';
    switch (statusCode) {
      case 400:
      case 401:
        message = ExceptionHandler.KUnAuthorized;
        break;
      case 403:
        message = ExceptionHandler.KUnAuthorized;
        break;
      case 404:
        message = "Not found";
        break;
      case 409:
        message = "Error due to a conflict";
        break;
      case 408:
        message = "Connection request timeout";
        break;
      case 500:
        message = "Internal Server Error";
        break;
      case 503:
        message = "Service unavailable";
        break;
      default:
        var responseCode = statusCode;
        message = "Received invalid status code: $responseCode";
    }
    return message;
  }
}
