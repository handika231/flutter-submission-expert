import 'package:ditonton/common/security_client.dart';
import 'package:http/http.dart' as http;

class SSLPinning {
  static http.Client? _client;
  static http.Client get client => _client ?? http.Client();

  static Future<http.Client> get _instance async {
    return _client ??= await SecurityClient.createSecurityClient();
  }

  static Future<void> init() async {
    _client = await _instance;
  }
}
