import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:training/adapterers/message_addapter.dart';
import 'package:training/main.dart';

class ChatBloc {
  final BehaviorSubject<List<ChannelModel>> _channels = BehaviorSubject();
  final BehaviorSubject<List<ChatMessageModel>> _chats = BehaviorSubject();

  BehaviorSubject<List<ChannelModel>> get getChannel => _channels;
  BehaviorSubject<List<ChatMessageModel>> get getChats => _chats;

  fetchChannel() {
    List<ChannelModel> _tempList =
        Hive.box<ChannelModel>(channelBoxName).values.toList();

    _channels.add(_tempList);
  }

  fetchChats() {
    List<ChatMessageModel> _tempList =
        Hive.box<ChatMessageModel>(chatBoxName).values.toList();

    _chats.add(_tempList);
  }
}

ChatBloc chatBloc = ChatBloc();
