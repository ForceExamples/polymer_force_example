/// Dart API for the polymer element `force-register`.
library force_elements.force_register_dart;

import 'dart:html';
import 'package:force/force_browser.dart';
import 'package:polymer/polymer.dart';

import 'package:force_elements/force_element.dart';
import 'package:cargo/cargo_client.dart';

class ObservableViewCollection extends Object with Observable {
  final ObservableList items = new ObservableList();
  
  ObservableMap mapItems = new ObservableMap.linked();
  
  ViewCollection _viewCollection;
  
  activate(ViewCollection viewCollection) {
      this._viewCollection = viewCollection;
      // Insert the message at the bottom of the current list, or at a given index.

      viewCollection.onChange((DataEvent de) {
         /*if (de.type==DataType.CHANGED) {
             mapItems[de.key] = (toObservable(de.data));
         }
         if (de.type==DataType.REMOVED) {
             items.remove(toObservable(de.data));
         }*/
         
         mapItems.clear();
         mapItems.addAll(toObservable(_viewCollection.data, deep: false));
      });
  }
  
  void add(value) {
    this._viewCollection.set(value);
  }
}

/// Element that registers a viewcollection within forcer
///
///     <force-register forceClientId="fcid" name="todos" viewCollection="{{todos}}"></force-register>
@CustomTag('force-register')
class ForceRegisterElement extends ForceElement {
  Cargo cargo;
  
  factory ForceRegisterElement() => new Element.tag('force-register');
  ForceRegisterElement.created() : super.created();
  
  /**
   * The url we need to connect to
   *
   * @attribute name
   * @type string
   * @default 'default'
   */
  @published String name = 'default';
  
  /**
   * viewCollection that is been observable
   *
   * @attribute name
   * @type string
   * @default 'default'
   */
  @published ObservableViewCollection viewCollection = new ObservableViewCollection();
    
    
  
  void connected() {
    if (cargo==null) {
        cargo = new Cargo(MODE: CargoMode.LOCAL); 
    }
    ViewCollection todos = forceClient.register(name, cargo);
    
    viewCollection.activate(todos);
    //this.asyncFire('registered');
  }
}