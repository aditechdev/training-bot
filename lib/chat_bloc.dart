import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:training/adapterers/message_addapter.dart';
import 'package:training/main.dart';
import 'package:training/services/bot_api.dart';
import 'package:uuid/uuid.dart';

class ChatBloc {
  final BehaviorSubject<List<ChannelModel>> _channels = BehaviorSubject();
  final BehaviorSubject<List<ChatMessageModel>> _chats = BehaviorSubject();
  static Box<ChatMessageModel>? chatBox;
  static Box<ChannelModel>? messageBox;
  static Box? botBox;
  BotApi botApi = BotApi();
  Uuid uuid = const Uuid();

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
    botBox = await Hive.openBox("BOTBOX");
    chatBox = Hive.box<ChatMessageModel>(chatBoxName);
    messageBox = Hive.box<ChannelModel>(channelBoxName);
  }

  botBoxSync() async {
    try {
      Map botData = await botApi.fetchBotMessage();

      if (botData.containsKey('restaurant')) {
        for (var item in botData['restaurant']) {
          await putBotData(item);
        }
      }
    } catch (e) {}
  }

  putBotData(Map data) async {
    var chatID = uuid.v1();

    await botBox?.put(chatID, data);
  }

  List<ChatMessageModel> fetchCurrentChannelMessages(String channelID) {
    List<ChatMessageModel> _temp = _chats.stream.value;

    _temp.sort((a, b) => b.date.compareTo(a.date));

    return _temp.where((element) => element.channelID == channelID).toList();
  }

  ChatMessageModel fetchLastMessage(String channelID) {
    List<ChatMessageModel> _temp = _chats.stream.value;
    _temp.sort((b, a) => b.date.compareTo(a.date));
    return _temp.lastWhere((element) => element.channelID == channelID);
  }

  createChannel(String title, channelID, selectedLanguage, image) async {
    //  =

    await messageBox
        ?.add(ChannelModel(title, channelID, selectedLanguage, image));
  }

  Future<void> createChat(bool isBot, String message, String createdAt,
      String userName, String channelID, String chatID) async {
    message = message.trim();
    await chatBox?.add(ChatMessageModel(
        isBot, message, createdAt, userName, channelID, chatID));
    await fetchChats();
    fetchLastMessage(channelID);
    fetchCurrentChannelMessages(channelID);
    await fetchChannel();
    String botResponse = fetchBotAction(message);
    var botChatID = uuid.v1();
    await chatBox?.add(ChatMessageModel(
        true,
        botResponse,
        DateTime.now().millisecondsSinceEpoch.toString(),
        "bot",
        channelID,
        botChatID));
    await fetchChats();
    fetchLastMessage(channelID);
    fetchCurrentChannelMessages(channelID);
    await fetchChannel();

    // chatBloc.fetchLastMessage(channelData.channelID);
  }

  String fetchBotAction(String message) {
    // String reply = "";

    final r = botBox?.toMap().values.toList().firstWhere(
        (element) => element['human'] == message,
        orElse: () => null);

    if (r != null) {
      return r["bot"];
    } else {
      return "Incorrect respose 😔\n Please try again!";
    }
  }
}

ChatBloc chatBloc = ChatBloc();
