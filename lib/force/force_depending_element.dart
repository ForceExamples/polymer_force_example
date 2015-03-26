/// Dart API for the abstract force polymer element that depends on ForceClientElement
library force_elements.force_viewcollection_dart;

import 'dart:html';
import 'package:polymer/polymer.dart';

import 'force_client_element.dart';

abstract class ForceDependingElement extends PolymerElement {
  @observable ForceClientElement fcElement;

  @published String forceClientId;
  
  ForceDependingElement.created() : super.created();
  
  void forceClientIdChanged() {
        fcElement = document.querySelector('#$forceClientId');
        if (fcElement == null) return;
        if (fcElement.loaded) {
          connected();
        } else {
          fcElement.on['force-client-connected'].take(1).listen((_) => connected());
        }
  }

  void connected();
  
}