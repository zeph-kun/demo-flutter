import 'message.dart';

class User {
  String _nom;
  String _prenom;
  List<Message> messages = [];
  User(this._nom, this._prenom);
  String get nom => _nom;
  String get prenom => _prenom;
  set nom(String value) {
    if (value.isNotEmpty) {
      _nom = value;
    }
  }
  set prenom(String value) {
    if (value.isNotEmpty) {
      _prenom = value;
    }
  }
  set message(Message value) {
    if (value != null) {
      messages.add(value);
    }
  }
}