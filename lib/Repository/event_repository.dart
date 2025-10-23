import 'package:dio/dio.dart';
import 'package:event_management_system/Services/token_storage.dart';
import '../Constants/routes.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: event_base_url,
    connectTimeout: const Duration(seconds: 80),
    receiveTimeout: const Duration(seconds: 150),
  ),
);

class EventProvider {
  Future<Map<String, dynamic>> createEvent(FormData data) async {
    final String? token = await TokenStorage.getToken();

    try {
      final response = await dio.post(
        '/createEvent',
        data: data,
        options: Options(
          headers: {
            "Authorization": token,
            "Content-Type": "multipart/form-data",
          },
        ),
      );

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
      } else if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.unknown) {
        return {'success': false, 'message': 'No internet connection'};
      }
      return {'success': false, 'message': 'Unexpected error occurred'};
    } catch (e) {
      // Any other unhandled error
      return {'success': false, 'message': 'Something went wrong'};
    }
  }

  Future<Map<String, dynamic>> loadEvents() async {
    final String? token = await TokenStorage.getToken();
    dio.options.headers['Authorization'] = '$token';
    dio.options.headers['Content-Type'] = 'application/json';
    try {
      final response = await dio.get('/loadEvent');

      return {
        'success': response.data['success'],
        'message': response.data['message'],
        'events': response.data['events'],
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
      } else if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.unknown) {
        return {'success': false, 'message': 'No internet connection'};
      }
      return {'success': false, 'message': 'Unexpected error occurred'};
    } catch (e) {
      // Any other unhandled error
      return {'success': false, 'message': 'Something went wrong'};
    }
  }

  Future<Map<String, dynamic>> loadOrganizerEvents() async {
    final String? token = await TokenStorage.getToken();
    dio.options.headers['Authorization'] = '$token';
    dio.options.headers['Content-Type'] = 'application/json';
    try {
      final response = await dio.get('/loadOrganizerEvent');

      return {
        'success': response.data['success'],
        'message': response.data['message'],
        'events': response.data['events'],
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
      } else if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.unknown) {
        return {'success': false, 'message': 'No internet connection'};
      }
      return {'success': false, 'message': 'Unexpected error occurred'};
    } catch (e) {
      // Any other unhandled error
      return {'success': false, 'message': 'Something went wrong'};
    }
  }

  Future<Map<String, dynamic>> bookEvent(Map<String, dynamic> data) async {
    final String? token = await TokenStorage.getToken();

    try {
      final response = await dio.post(
        '/bookEvent',
        data: data,
        options: Options(headers: {"Authorization": token,"Content-Type": "application/json"}),
      );

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
      } else if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.unknown) {
        return {'success': false, 'message': 'No internet connection'};
      }
      return {'success': false, 'message': 'Unexpected error occurred'};
    } catch (e) {
      // Any other unhandled error
      return {'success': false, 'message': 'Something went wrong'};
    }
  }
}
