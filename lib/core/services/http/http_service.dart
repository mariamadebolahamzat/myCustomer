import 'dart:io';

abstract class HttpService {
  /// Send GET request to endpoint/[route] and return the `response`
  /// - if successful: returns decoded json data
  ///
  /// - throws `NetworkException` if GET fails
  Future<dynamic> getHttp(String route, {Map<String, dynamic> params});

  /// Send POST request with [body] to endpoint/[route] and return the `response`
  /// - if successful: returns decoded json data
  ///
  /// - throws `NetworkException` if POST request fails
  Future<dynamic> postHttp(String route, dynamic body, {Map<String, dynamic> params});

  /// Send POST request with [body] to endpoint/[route] and return the `response`
  /// - if successful: returns decoded json data
  ///
  /// - throws `NetworkException` if POST request fails
  Future<dynamic> putHttp(String route, dynamic body, {Map<String, dynamic> params});

  /// Set the header to use for further requests
  setHeader(Map<String, dynamic> header);

  /// Clear headers set
  clearHeaders();

  void dispose();
}
