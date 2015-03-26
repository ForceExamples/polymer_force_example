/// Dart API for the polymer element `force-client`.
library force_elements.force_client_dart;

import 'dart:html';
import 'dart:convert' show JSON;
import 'package:force/force_browser.dart';
import 'package:polymer/polymer.dart';

/// Element access to ForceClient object
/// it will establish a forceClient connection to a server
///
///     <force-client url="localhost" port="4040" usePolling="true" heartbeat="600"></force-client>
@CustomTag('force-client')
class ForceClientElement extends PolymerElement {
  /**
   * Fired when a forceClient is connected to the server.
   * @event force-client-connected
   */

  /**
   * The url we need to connect to
   *
   * @attribute url
   * @type string
   * @default null
   */
  @published String url;

  /**
   * The host we need to connect to, http://localhost:3333 for example
   *
   * @attribute host
   * @type string
   * @default null
   */
  @published String host;

  /**
   * The port we need to connect to.
   *
   * @attribute port
   * @type int
   * @default null
   */
  @published int port;
  
  /**
   * What is the heartbeat of this connection
   *
   * @attribute heartbeat
   * @type int
   * @default false
   */
  @published int heartbeat = 500;

  /**
   * If true, force client will use polling 
   *
   * @attribute usePolling
   * @type boolean
   * @default false
   */
  @published bool usePolling = false;

  @observable bool loaded = false;
  
  @observable ForceClient forceClient;

  factory ForceClientElement() => new Element.tag('force-client');
  ForceClientElement.created() : super.created();
  
  void attached() {
      async((_) {
        forceClient = new ForceClient(url: url, host: host, port: port, heartbeat: heartbeat, usePolling: usePolling);
        connect();
      });
    }

  void connect() {
    forceClient.connect();
    
    forceClient.onConnected.listen((ConnectEvent ce) {
      this.loaded = true;
      this.asyncFire('force-client-connected');
    });
  }

  
}
