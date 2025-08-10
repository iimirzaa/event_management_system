import 'package:dio/dio.dart';
import '../../constants/routes.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: auth_base_url,
    connectTimeout: const Duration(seconds: 80),
    receiveTimeout: const Duration(seconds: 80),
  ),
);

class AuthProvider {
  Future<Map<String, dynamic>> sendSignUpOTP(Map<String, dynamic> data) async {
    try {
      final response = await dio.post('/signUp', data: data);

      return {
        'success': response.data['success'],
        'message': response.data['message'],
      };
    } on DioException catch (e) {
      // Dio-specific error handling
      if (e.type == DioExceptionType.connectionTimeout) {
        return {'success': false, 'message': 'Connection timeout'};
      } else if (e.type == DioExceptionType.receiveTimeout) {
        return {'success': false, 'message': 'Receive timeout'};
      } else if (e.type == DioExceptionType.badResponse) {
        // When backend sends error response (like 400/500)
        final statusCode = e.response?.statusCode ?? 0;
        final message = e.response?.data?['message'] ?? 'Unexpected error';
        return {'success': false, 'message': '[$statusCode] $message'};
      } else if (e.type == DioExceptionType.unknown) {
        return {'success': false, 'message': 'No internet connection'};
      }
      return {'success': false, 'message': 'Unexpected error occurred'};
    } catch (e) {
      // Any other unhandled error
      return {'success': false, 'message': 'Something went wrong'};
    }
  }

  Future<Map<String, dynamic>> sendOTP(Map<String, dynamic> data) async {
    try {
      final response = await dio.post('/sendOtp', data: data);
      return {
        'success': response.data['success'],
        'message': response.data['message'],
      };
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return {'success': false, 'message': 'Connection timeout'};
      } else if (e.type == DioExceptionType.receiveTimeout) {
        return {'success': false, 'message': 'Receive timeout'};
      } else if (e.type == DioExceptionType.badResponse) {
        final statusCode = e.response?.statusCode ?? 0;
        final message = e.response?.data?['message'] ?? 'Unexpected error';
        return {'success': false, 'message': '[$statusCode] $message'};
      } else if (e.type == DioExceptionType.unknown) {
        return {'success': false, 'message': 'No internet connection'};
      }
      return {'success': false, 'message': 'Unexpected error occurred'};
    } catch (e) {
      return {'success': false, 'message': 'Something went wrong'};
    }
  }
}
