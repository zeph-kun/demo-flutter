import 'package:listview/models/message.dart';
import 'package:listview/models/user.dart';

class MessageController {
  final List<Message> _messages = [];
  List<Message> get messages => _messages;
  Future<void> loadMessages() async {
    messages.add(Message('Sujet 1', 'Contenu 1', DateTime.now(), User('Dupont', 'Jean')));
    messages.add(Message('Sujet 2', 'Contenu 2', DateTime.now(), User('Durand', 'Pierre')));
    messages.add(Message('Sujet 3', 'Contenu 3', DateTime.now(), User('Martin', 'Paul')));
    messages.add(Message('Sujet 4', 'Contenu 4', DateTime.now(), User('Leclerc', 'Marie')));
    messages.add(Message('Sujet 5', 'Contenu 5', DateTime.now(), User('Bertrand', 'Luc')));
    messages.add(Message('Sujet 6', 'Contenu 6', DateTime.now(), User('Dupont', 'Jean')));
    messages.add(Message('Sujet 7', 'Contenu 7', DateTime.now(), User('Durand', 'Pierre')));
    messages.add(Message('Sujet 8', 'Contenu 8', DateTime.now(), User('Martin', 'Paul')));
    messages.add(Message('Sujet 9', 'Contenu 9', DateTime.now(), User('Leclerc', 'Marie')));
    messages.add(Message('Sujet 10', 'Contenu 10', DateTime.now(), User('Bertrand', 'Luc')));
    messages.add(Message('Sujet 11', 'Contenu 11', DateTime.now(), User('Dupont', 'Jean')));
    messages.add(Message('Sujet 12', 'Contenu 12', DateTime.now(), User('Durand', 'Pierre')));
    messages.add(Message('Sujet 13', 'Contenu 13', DateTime.now(), User('Martin', 'Paul')));
    messages.add(Message('Sujet 14', 'Contenu 14', DateTime.now(), User('Leclerc', 'Marie')));
    messages.add(Message('Sujet 15', 'Contenu 15', DateTime.now(), User('Bertrand', 'Luc')));
  }
}