import 'package:listview/models/user.dart';

class Message {
  String _sujet;
  String _contenu;
  DateTime _dateEnvoi;
  User _auteur;
  Message(this._sujet, this._contenu, this._dateEnvoi, this._auteur);

  String get sujet => _sujet;
  String get contenu => _contenu;
  DateTime get dateEnvoi => _dateEnvoi;
  User get auteur => _auteur;

  set sujet(String value) {
    if (value.isNotEmpty) {
      _sujet = value;
    }
  }
  set contenu(String value) {
    if (value.isNotEmpty) {
      _contenu = value;
    }
  }
  set dateEnvoi(DateTime value) {
    if (value != null) {
      _dateEnvoi = value;
    }
  }
  set auteur(User value) {
    if (value != null) {
      _auteur = value;
    }
  }
}