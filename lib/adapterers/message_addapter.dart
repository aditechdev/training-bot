import 'package:hive/hive.dart';
part 'message_addapter.g.dart';

@HiveType(typeId: 0)
class MessageModel {
  @HiveField(0)
  String topic;
  @HiveField(1)
  List<ChattMessage> chatMessage;
  @HiveField(2)
  String language;
  @HiveField(3)
  String color;
  @HiveField(4)
  String image;

  MessageModel(this.topic, this.chatMessage, this.color, this.language, this.image);
}

@HiveType(typeId: 1)
class ChattMessage {
  @HiveField(0)
  String message;
  @HiveField(1)
  bool bot;
  @HiveField(2)
  String date;
  @HiveField(3)
  String userName;

  ChattMessage(
    this.bot,
    this.message,
    this.date,
    this.userName,
  );
}
