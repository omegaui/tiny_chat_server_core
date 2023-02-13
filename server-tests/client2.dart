
import '../bin/data/user.dart';
import '../bin/internal/client.dart';

void main(){
  var host = "localhost:8080";
  var c2 = Client(host, User(uniqueID: 'blazeui', serverCode: "devs"));
  c2.send("hi");
}

