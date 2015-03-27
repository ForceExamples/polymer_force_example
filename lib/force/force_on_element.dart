/// Dart API for the polymer element `force-register`.
library force_elements.force_register_dart;

import 'dart:html';
import 'package:force/force_browser.dart';
import 'package:polymer/polymer.dart';

import 'force_depending_element.dart';

/// Element that registers a viewcollection within forcer
///
///     <force-on forceClientId="fcid" request="listen" data="{{data}}" profile="{{profile}}"></force-on>
@CustomTag('force-on')
class ForceOnElement extends ForceDependingElement {
  /**
   * Fired when a forceClient is connected to the server.
   * @event force-on-received
   */
  
  factory ForceOnElement() => new Element.tag('force-on');
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
  
  /**
   * viewCollection that is been observable
   *
   * @attribute name
   * @type string
   * @default ''
   */
  @published var profile = '';
    
    
  
  void connected() {
    fcElement.forceClient.on(request, (MessagePackage fme, Sender sender) {
      data = fme.json;
      profile = fme.profile;
      
      this.asyncFire("force-on-received", detail: data);
    });
    //this.asyncFire('registered');
  }
}