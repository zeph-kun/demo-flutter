import 'package:flutter/material.dart';
import 'package:listview/models/message.dart';


class MessageDetailScreen extends StatelessWidget {
  final Message message;
  const MessageDetailScreen({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${message.sujet} - ${message.auteur.nom}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('Contenu: ${message.contenu}\nDate: ${message.dateEnvoi.toIso8601String()}'),
      ),
    );
  }
}