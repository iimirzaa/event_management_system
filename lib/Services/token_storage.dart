import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
class TokenStorage{
  static final storage = FlutterSecureStorage();
  static Future<void> saveToken(String token)async{
    await storage.write(key:"jwt",value: token);
  }
  static Future<String?> getToken() async {
    return await storage.read(key:'jwt');
  }
  static Future<void> deleteToken() async {
    await storage.delete(key: 'jwt');
  }
  static Future<Map<String, dynamic>?> getDecodedToken() async {
    final token = await getToken();
    if (token == null) return null;

    if (JwtDecoder.isExpired(token)) {
      await deleteToken();
      return null;
    }
    return JwtDecoder.decode(token);
  }
  static Future<String?> getRole() async {
    final decoded = await getDecodedToken();
    return decoded?['role'];
  }
  static Future<String?> getEmail() async {
    final decoded = await getDecodedToken();
    return decoded?['email'];
  }
  static Future<String?> getName()async{
    final decoded=await getDecodedToken();
    return decoded? ['name'];
  }
  static Future<bool?> getProfilePic() async {
    final decoded = await getDecodedToken();
    return decoded?['hasprofilepic'];
  }
}