import 'package:flutter/material.dart';
import 'message_database.dart';
import 'message_model.dart';

// MessageProvider with added functionalities
class MessageProvider with ChangeNotifier {
  List<Message> _messages = [];
  String _searchQuery = '';

  List<Message> get messages => _messages;
  String get searchQuery => _searchQuery;

  void loadMessages() async {
    _messages = await MessageDatabase.instance.retrieveMessages();
    notifyListeners();
  }

  void setMessages(List<Message> messages) {
    _messages = messages;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void deleteMessage(int id) async {
    await MessageDatabase.instance.deleteMessage(id);
    loadMessages();
  }

  void updateMessage(Message message) async {
    await MessageDatabase.instance.updateMessage(message);
    loadMessages();
  }
}