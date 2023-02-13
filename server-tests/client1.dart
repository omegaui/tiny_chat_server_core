
import '../bin/data/user.dart';
import '../bin/internal/client.dart';

void main(){
  var host = "192.168.190.151:8080";
  var c1 = Client(host, User(uniqueID: 'omegaui', serverCode: "devs"));
  c1.send("hello");
  c1.send("What are you doing?");
}

