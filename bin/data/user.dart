import 'dart:convert';

class User {
  final String uniqueID;
  final String serverCode;

  User({required this.uniqueID, required this.serverCode});

  @override
  String toString() {
    return jsonEncode({'uniqueID': uniqueID, 'serverCode': serverCode});
  }

  static User fromJSON(String json) {
    dynamic data = jsonDecode(json);
    return User(uniqueID: data['uniqueID'], serverCode: data['serverCode']);
  }
}
