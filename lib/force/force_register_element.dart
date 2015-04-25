/// Dart API for the polymer element `force-register`.
library force_elements.force_register_dart;

import 'dart:html';
import 'package:force/force_browser.dart';
import 'package:polymer/polymer.dart';

import 'package:force_elements/force_element.dart';
import 'package:cargo/cargo_client.dart';

class ObservableViewCollection extends Object with Observable {
  final ObservableList keys = new ObservableList();
  
  ObservableMap data = new ObservableMap.linked();
  
  ViewCollection _viewCollection;
  
  activate(ViewCollection viewCollection) {
      this._viewCollection = viewCollection;
      // Insert the message at the bottom of the current list, or at a given index.

      viewCollection.onChange(dataChanges);
  }
  
  dataChanges(DataEvent de) {
      if (de.type==DataType.CHANGED) {
          data[de.key] = (toObservable(de.data));
               
          if (this._viewCollection.options.revert) {
              keys.insert(0, de.key);
          } else {
              keys.add(de.key);
          }
      }
      if (de.type==DataType.REMOVED) {
          data.remove(toObservable(de.data));
      }
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
   * Do you want to have the collection revert
   *
   * @attribute revert
   * @type bool
   * @default false
   */
  @published bool revert = false;
  
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
   * @attribute collection
   * @type ObservableViewCollection
   * @default new ObservableViewCollection();
   */
  @published ObservableViewCollection collection = new ObservableViewCollection();
    
  
  /**
   * All keys in data (array of names, if you think of data as a set of name/value pairs).
   *
   * @attribute keys
   * @type string
   * @default 'default'
   */
  @published ObservableList keys;
  
  /**
   * The query params of the collection, so you can filter the collection to your needs.
   *
   * @attribute params
   * @type string
   * @default 'default'
   */
  @published ObservableMap params;
  
  bool loaded = false;
      
  void connected() {
    if (cargo==null) {
        cargo = new Cargo(MODE: CargoMode.LOCAL); 
    }
    this._recollect(new Options(revert: revert));
    //this.asyncFire('registered');
    
    loaded = true;
  }
  
  void _recollect(Options options) {
    ViewCollection todos = forceClient.register(name, cargo, options: options, params: params);
    collection.activate(todos);
        
    keys = collection.keys;
  }
  
  void paramsChanged() {
    if (loaded) this._recollect(new Options(revert: revert));
  }
  
  void revertChanged() {
    if (loaded) this._recollect(new Options(revert: revert));
  }
}