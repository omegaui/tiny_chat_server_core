
# tiny-chat-server-core

This is a very basic implementation of a passcode protected server,
where a user can use this program to host a local server on its machine and let others join through the `server-code`
and `uniqueID`.

**Launching** a server **requires** a `server-config.json`:
```json
{
  "name": "\uD83D\uDE0E rock-n-roll \uD83D\uDE0E",
  "host-address": "192.168.190.151",
  "owner-id": "@omegaui",
  "connections-limit": 10, // -1 for unlimited users
  "allowed-users-list": ["xyz", "pqr"],
  "blocked-users-list": ["abc"],
  "push-previous-messages-to-new-users": true,
  "server-code": "devs"
}
```

### Implementations:

- [x] Remote Connections
- [x] Blocking Users
- [ ] Sending Files and other Codes

## Launching 
Simply launch `internal/server.dart` to start the server.

And later on for connections create instances of `Client` from `client.dart`:
```dart

import '../bin/data/user.dart';
import '../bin/internal/client.dart';

void main(){
  var host = "localhost:8080";
  var c1 = Client(host, User(uniqueID: 'omegaui', serverCode: "devs"));
  c1.send("hello");
  c1.send("What are you doing?");
}
```

