/// Dart API for the polymer element `force-register`.
library force_elements.force_send_dart;

import 'dart:html';
import 'package:force/force_browser.dart';
import 'package:polymer/polymer.dart';

import 'package:force_elements/force_element.dart';

/// Element that can send data to a certain endpoint over websockets
///
///     <force-send forceClientId="fcid" request="listen" data="{{data}}"></force-send>
@CustomTag('force-send')
class ForceOnElement extends ForceElement {
  /**
   * Fired when a forceClient is connected to the server.
   * @event force-on-received
   */
  
  factory ForceOnElement() => new Element.tag('force-send');
  ForceOnElement.created() : super.created();
  
  /**
   * The url we need to connect to
   *
   * @attribute request
   * @type string
   * @default 'default'
   */
  @published String request = 'default';
  
  /**
   * viewCollection that is been observable
   *
   * @attribute name
   * @type string
   * @default ''
   */
  @published var data = '';
  
  bool loaded = false;
  
  void connected() {
    loaded = true;
  }
  
  attributeChanged(String name, String oldValue, String newValue) {
    //super.attributeChanges(name, oldValue, newValue);
    if (name=='data' && loaded) {
        forceClient.send(request, data);
    }
  }
}