import 'package:flutter/material.dart';
import 'package:listview/models/message.dart';
import 'package:listview/controllers/user_controller.dart';
import 'package:listview/controllers/message_controller.dart';
import 'package:listview/models/user.dart';
import 'package:listview/screens/message_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.prenom} ${user.nom}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Détails de ${user.prenom} ${user.nom}'),
            Expanded(
              child: ListView.builder(
                itemCount: user.messages.length,
                itemBuilder: (BuildContext context, int index) {
                  Message message = user.messages[index];
                  return ListTile(
                    title: Text('${message.sujet} - ${message.auteur.nom}'),
                    subtitle: Text(message.contenu),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeScreen extends State<HomeScreen> {
  UserController _userController = UserController();
  MessageController _messageController = MessageController();

  final _formKey = GlobalKey<FormState>();
  String _nom = "";
  String _prenom = "";

  @override
  void initState() {
    super.initState();
    _userController.loadUsers();
    _messageController.loadMessages();
  }

  void onFabPressed(context) {
    int selectedIndex = DefaultTabController.of(context).index;
    if (selectedIndex == 0) {
      form();
    } else if (selectedIndex == 1) {
      formMessage();
    }
  }

  void addMessage(Message message) {
    _messageController.messages.add(message);
    setState(() {});
  }

  Widget _buildMessageList() {
    return ListView.builder(
      itemCount: _messageController.messages.length,
      itemBuilder: (BuildContext context, int index) {
        Message message = _messageController.messages[index];
        return ListTile(
          title: Text('${message.sujet} - ${message.auteur.nom}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MessageDetailScreen(message: message),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildUserList() {
    return ListView.builder(
      itemCount: _userController.users.length,
      itemBuilder: (BuildContext context, int index) {
        User user = _userController.users[index];
        return Dismissible(
          key: Key(user.nom),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction) {
            _userController.users.removeAt(index);
            setState(() {});
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          child: Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text('${user.prenom} ${user.nom}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDetailScreen(user: user),
                  ),
                );
              },
            )
          ),
        );
      },
    );
  }

  void form() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ajouter un utilisateur'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nom',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Veuillez saisir un nom';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _nom = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Prénom',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Veuillez saisir un prénom';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _prenom = value ?? '';
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState?.save();
                  User user = User(_nom, _prenom);
                  _userController.users.add(user);
                  Navigator.of(context).pop();
                  setState(() {});
                }
              },
              child: const Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }

  void formMessage() {
    String _sujet = "";
    String _contenu = "";
    User _auteur = _userController.users.first;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ajouter un message'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Sujet',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Veuillez saisir un sujet';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _sujet = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Contenu',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Veuillez saisir un contenu';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _contenu = value ?? '';
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState?.save();
                  Message message = Message(_sujet, _contenu, DateTime.now(), _auteur);
                  _messageController.messages.add(message);
                  _auteur.messages.add(message);
                  Navigator.of(context).pop();
                  setState(() {});
                }
              },
              child: const Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter', style: TextStyle(color: Colors.white)),
          elevation: 10.0,
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.people, color: Colors.white)),
              Tab(icon: Icon(Icons.message, color: Colors.white)),
            ],
          ),
        ),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: TabBarView(
          children: [
            _buildUserList(),
            _buildMessageList(),
          ],
        ),
        floatingActionButton: Builder( // Add Builder here
          builder: (BuildContext context) {
            return FloatingActionButton(
              onPressed: () => onFabPressed(context), // Pass the context to onFabPressed
              child: const Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }
}