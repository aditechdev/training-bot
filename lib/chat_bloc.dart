import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:training/adapterers/message_addapter.dart';

class ChatBloc {
  BehaviorSubject<Iterable<ChannelModel>> _channels = BehaviorSubject();
  BehaviorSubject<Iterable<ChatMessageModel>> _chats = BehaviorSubject();

  BehaviorSubject<Iterable<ChannelModel>> get getChannel => _channels;
  BehaviorSubject<Iterable<ChatMessageModel>> get getChats => _chats;

  fetchChannel() {
    // List<channelModel> _temp = Hive.box<channelModel>('channelModel');
    // Iterable<channelModel> _temp =
    //     Hive.box<channelModel>("channelModel").values;

    // _channels.add(_temp);
  }

  fetchChats() {}
}
