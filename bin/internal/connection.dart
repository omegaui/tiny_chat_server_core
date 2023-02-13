
import 'package:shelf_plus/shelf_plus.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../data/user.dart';

class Connection {
  final User user;
  final WebSocketSession session;

  Connection(this.user, this.session);

  @override
  String toString() {
    return user.toString();
  }
}

WebSocketChannel connect(String hostAddress, User user) {
  return WebSocketChannel.connect(
      Uri.parse("ws://$hostAddress/connect/${user.toString()}"));
}
