import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
part 'message_addapter.g.dart';

@HiveType(typeId: 0)
class ChannelModel {
  @HiveField(0)
  String topic;
  @HiveField(1)
  String channelID;
  @HiveField(2)
  String language;
  @HiveField(3)
  String channelImage;

  ChannelModel(this.topic, this.channelID, this.language, this.channelImage);
}

@HiveType(typeId: 1)
class ChatMessageModel {
  @HiveField(0)
  String message;
  @HiveField(1)
  bool isBot;
  @HiveField(2)
  String date;
  @HiveField(3)
  String userName;
  @HiveField(4)
  String channelID;
  @HiveField(5)
  String chatID;

  ChatMessageModel(this.isBot, this.message, this.date, this.userName,
      this.channelID, this.chatID);

  String getDate() {
    DateTime d =
        DateTime.fromMillisecondsSinceEpoch((int.parse(date)), isUtc: true)
            .toLocal();
    DateFormat formatter = DateFormat('MM/dd/yyyy h:mm:ss');
    final String formatted = formatter.format(d);

    return formatted;
  }
}
