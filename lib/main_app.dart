// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:polymer/polymer.dart';
import 'package:cargo/cargo_client.dart';

import 'force/force_register_element.dart';

import 'todo.dart';

class Todos extends Object with Observable {
  final List items = toObservable([]);
  
  void add(message) {
      // Insert the message at the bottom of the current list, or at a given index.
      items.add(toObservable(message));
    }
}

/// A Polymer `<main-app>` element.
@CustomTag('main-app')
class MainApp extends PolymerElement {
  @observable String message = '';
  
  @published Todos todos = new Todos();
  @published ObservableViewCollection todosView;
  
  @published String forceClientId;
  
  @published var number;
  
  /// Constructor used to create instance of MainApp.
  MainApp.created() : super.created() {}
  
  void activate() {
    if (todosView!=null) {
      print("this is a test!");
    }
  }

  void add() {
    todos.add(message);
    if (todosView!=null) {
      todosView.add(message);
    }
  }

  // Optional lifecycle methods - uncomment if needed.

//  /// Called when an instance of main-app is inserted into the DOM.
//  attached() {
//    super.attached();
//  }

//  /// Called when an instance of main-app is removed from the DOM.
//  detached() {
//    super.detached();
//  }

//  /// Called when an attribute (such as a class) of an instance of
//  /// main-app is added, changed, or removed.
//  attributeChanged(String name, String oldValue, String newValue) {
//    super.attributeChanges(name, oldValue, newValue);
//  }

//  /// Called when main-app has been fully prepared (Shadow DOM created,
//  /// property observers set up, event listeners attached).
//  ready() {
//    super.ready();
//  }
}
