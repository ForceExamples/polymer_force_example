library models;

class Todo {
  String name;
  
  DateTime date;
  
  static Todo deserializeFromJson(Map json) => new Todo.fromJson(json);

  Todo(this.name) {
    this.date = new DateTime.now();
  }

  Todo.fromJson(Map data) {
    name    = data["name"];
  
    date = new DateTime(data["date"]["year"], data["date"]["month"], data["date"]["day"]);
  }
  
  Map toJson() => {"name": name, "date": { "day": date.day, "month": date.month, "year": date.year }};

  String toString() {
    return name;
  }
}