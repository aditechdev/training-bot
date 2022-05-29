import 'package:hive/hive.dart';
part 'message_addapter.g.dart';

@HiveType(typeId: 0)
class MessageModel { // TODO Channel Model
  @HiveField(0)
  String topic;
  @HiveField(1)
  String chatID; // TODO Change to Channel ID
  @HiveField(2)
  String language;
  @HiveField(4)
  String image;  

  MessageModel(this.topic,this.chatID, this.language, this.image);
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
  @HiveField(4)
  String chatID;

  ChattMessage(
    this.bot,
    this.message,
    this.date,
    this.userName,
    this.chatID
  );
}
