import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:training/adapterers/message_addapter.dart';
import 'package:training/main.dart';

class ChatBloc {
  final BehaviorSubject<List<ChannelModel>> _channels = BehaviorSubject();
  final BehaviorSubject<List<ChatMessageModel>> _chats = BehaviorSubject();
  static Box<ChatMessageModel>? chatBox;
  static Box<ChannelModel>? messageBox;

  BehaviorSubject<List<ChannelModel>> get getChannel => _channels;
  BehaviorSubject<List<ChatMessageModel>> get getChats => _chats;

  fetchChannel() {
    List<ChannelModel> _tempList = messageBox!.values.toList();

    _channels.add(_tempList);
  }

  fetchChats() {
    List<ChatMessageModel> _tempList = chatBox!.values.toList();

    _chats.add(_tempList);
  }

  Future<void> openBox() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ChannelModelAdapter());
    Hive.registerAdapter(ChatMessageModelAdapter());
    await Hive.openBox<ChannelModel>(channelBoxName);
    await Hive.openBox<ChatMessageModel>(chatBoxName);
    chatBox = Hive.box<ChatMessageModel>(chatBoxName);
    messageBox = Hive.box<ChannelModel>(channelBoxName);
  }

  List<ChatMessageModel> fetchCurrentChannelMessages(String channelID) {
    List<ChatMessageModel> _temp = _chats.stream.value;

    _temp.sort((a, b) => b.date.compareTo(a.date));

    return _temp.where((element) => element.channelID == channelID).toList();
  }

  ChatMessageModel fetchLastMessage(String channelID) {
    List<ChatMessageModel> _temp = _chats.stream.value;

    return _temp.lastWhere((element) => element.channelID == channelID);
  }

  createChannel(String title, channelID, selectedLanguage, image) async {
    //  =

    await messageBox
        ?.add(ChannelModel(title, channelID, selectedLanguage, image));
  }

  Future<void> createChat(bool isBot, String message, String createdAt,
      String userName, String channelID, String chatID) async {
    await chatBox?.add(ChatMessageModel(
        isBot, message, createdAt, userName, channelID, chatID));
    await fetchChats();
    await fetchChannel();
    fetchLastMessage(channelID);
    // chatBloc.fetchLastMessage(channelData.channelID);
  }

  // Future<void> createBotChat() {

  // }
}

ChatBloc chatBloc = ChatBloc();
