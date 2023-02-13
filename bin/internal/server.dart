
import 'package:colored_print/colored_print.dart';

import '../data/user.dart';
import '../io/connection_manager.dart';
import '../io/request_handler.dart';
import '../io/server_config.dart';
import 'connection.dart';
import 'package:shelf_plus/shelf_plus.dart';

String serverConfigPath = "server-config.json";

RequestHandler requestHandler = RequestHandler.instance;
ConnectionManager connectionManager = ConnectionManager();

void main(List<String?> args) {
  if(args.isNotEmpty) {
    serverConfigPath = args.first ?? "server-config.json";
  }
  loadConfig();
  try {
    shelfRun(init, defaultBindAddress: configuration['host-address']);
  }
  catch(e){
    ColoredPrint.error("An Internal Error has occurred and the Server cannot be started!");
    ColoredPrint.error("Report the following log to fix this issue.");
    print(e);
  }
}

Handler init() {

  ColoredPrint.log(
    "Starting Server ... ${configuration['name']}",
    tag: "INIT",
    tagColor: PrintColor.cyan,
  );

  var router = Router().plus;

  // connection end-point
  router.get('/connect/<id>', (Request request, dynamic id) {
    var user = User.fromJSON(Uri.decodeFull(id));
    bool acceptable = requestHandler.accept(user);
    var session = WebSocketSession();
    if (acceptable) {
      Connection connection = Connection(user, session);

      session.onOpen = (session) => connectionManager.notifyJoin(connection);
      session.onClose = (session) => connectionManager.notifyLeave(connection);
      session.onMessage =
          (session, data) => connectionManager.message(session, data);
      ColoredPrint.log(
        user.uniqueID,
        tag: "JOINED",
        tagColor: PrintColor.cyan,
      );
      return session;
    }
    else{
      ColoredPrint.warning('Refused connection request from ${user.uniqueID}');
      print(requestHandler.refuseConnection(user));
      return "CONNECTION REFUSED";
    }
  });

  ColoredPrint.success("Server Started!");

  return router;
}
