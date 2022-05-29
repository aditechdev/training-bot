import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:training/adapterers/message_addapter.dart';

class ChatBloc {
  BehaviorSubject<Iterable<MessageModel>> _channels = BehaviorSubject();
  BehaviorSubject<Iterable<ChattMessage>> _chats = BehaviorSubject();

  BehaviorSubject<Iterable<MessageModel>> get getChannel => _channels;
  BehaviorSubject<Iterable<ChattMessage>> get getChats => _chats;

  fetchChannel() {
    // List<MessageModel> _temp = Hive.box<MessageModel>('messageModel');
    Iterable<MessageModel> _temp = Hive.box<MessageModel>("messageModel").values;

    _channels.add(_temp);
  }

  fetchChats() {}
}
