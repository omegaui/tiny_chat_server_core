import 'package:colored_print/colored_print.dart';

import '../data/user.dart';
import 'server_config.dart';

class RequestHandler {
  List<User> users = [];

  bool accept(User user) {
    if(alreadyLoggedIn(user)){
      ColoredPrint.warning("Duplicate Join Request from user id ${user.uniqueID}");
      return false;
    }
    var whiteList = configuration['allowed-users-list'];
    var blockList = configuration['blocked-users-list'];
    if (whiteList.isEmpty) {
      var blocked = false;
      if(blockList.isNotEmpty){
        blocked = blockList.contains(user.uniqueID);
      }
      return !blocked && user.serverCode == configuration['server-code'];
    }
    return whiteList.contains(user.uniqueID) &&
        user.serverCode == configuration['server-code'];

  }

  bool alreadyLoggedIn(User user){
    return users.where((userX) => userX.uniqueID == user.uniqueID).isNotEmpty;
  }

  bool isLimitReached() {
    var limit = configuration['connections-limit'];
    return limit > 0 && users.length > limit;
  }

  String refuseConnection(User user) {
    return PrintColor.red(
        "CONNECTION REFUSED!!! ${user.serverCode != configuration['serverCode'] ? 'INVALID SERVER CODE.' : 'USER NOT ALLOWED.'}${isLimitReached() ? ", Server Full!" : ""}");
  }

  static get instance {
    return RequestHandler();
  }
}
