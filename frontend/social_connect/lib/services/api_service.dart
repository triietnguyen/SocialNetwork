import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000'));

  Future<Response> login(String username, String password) async {
    try {
      final response = await _dio.post('/login', data: {
        'username': username,
        'password': password,
      });
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> register(String username, String password) async {
    try {
      final response = await _dio.post('/register', data: {
        'username': username,
        'password': password,
      });
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> checkConnection() async {
    try {
      final response = await _dio.get('/check-connection');
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }
}
