import 'package:colored_print/colored_print.dart';
import 'package:shelf_plus/shelf_plus.dart';

import '../internal/connection.dart';
import 'server_config.dart';

class ConnectionManager {
  List<Connection> connections = [];
  List<dynamic> messages = [];

  void notifyJoin(Connection connection) {
    add(connection);
    connections.where((conn) => conn.session != connection.session).forEach(
        (conn) => conn.session.send(
            "${PrintColor.blue("[JOINED]")} >>>> ${connection.user.uniqueID}"));
    connection.session.send("Successfully Joined Server ${PrintColor.blue(configuration['name'])} owned by ${PrintColor.magenta(configuration['owner-id'])}");
    if(configuration['push-previous-messages-to-new-users']) {
      for (var message in messages) {
        connection.session.send(message);
      }
    }
  }

  void notifyLeave(Connection connection) {
    connections.where((conn) => conn.session != connection.session).forEach(
        (conn) => conn.session.send(
            "${PrintColor.red("[LEFT]")}  >>>> ${connection.user.uniqueID}"));
    remove(connection);
  }

  void message(WebSocketSession session, dynamic data) {
    messages.add(data);
    connections.where((conn) => conn.session != session).forEach(
        (conn) => conn.session.send(data));
  }

  void add(Connection connection) {
    connections.add(connection);
  }

  void remove(Connection connection) {
    connections.add(connection);
  }
}
