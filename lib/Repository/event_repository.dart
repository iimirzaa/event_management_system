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
  Future<Map<String, dynamic>> createEvent(Map<String, dynamic> data) async {
    final String? token=await TokenStorage.getToken();
    dio.options.headers['Authorization'] = '$token';
    dio.options.headers['Content-Type'] = 'application/json';
    try {
      final response = await dio.post('/createEvent', data: data);

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
