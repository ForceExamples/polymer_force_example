library aproducthuntdart;

import 'package:force/force_serverside.dart';
import 'package:bigcargo/bigcargo.dart';
import 'dart:async';

main() {
  // You can also use a memory implementation here, just switch the CargoMode to MEMORY
  Cargo cargo = new Cargo(MODE: CargoMode.MEMORY);
  
  // Create a force server
  ForceServer fs = new ForceServer(port: 4040, 
                                 clientFiles: '../build/web/');
    
  // Setup logger
  fs.setupConsoleLog();
  
  // wait until our forceserver is been started and our connection with the persistent layer is done!
  Future.wait([fs.start(), cargo.start()]).then((_) { 
      // Tell Force what the start page is!
      fs.server.static("/", "index.html");
     
      fs.publish("todos", cargo, validate: (CargoPackage fcp, Sender sender) {
        if (fcp.json!=null) {
          // Perform some checks ...
          // call fcp.cancel() when the transaction needs to be cancelled
          
        }
      });
    
    });
}

