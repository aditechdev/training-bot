// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_addapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChannelModelAdapter extends TypeAdapter<ChannelModel> {
  @override
  final int typeId = 0;

  @override
  ChannelModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChannelModel(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ChannelModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.topic)
      ..writeByte(1)
      ..write(obj.channelID)
      ..writeByte(2)
      ..write(obj.language)
      ..writeByte(3)
      ..write(obj.channelImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChannelModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ChatMessageModelAdapter extends TypeAdapter<ChatMessageModel> {
  @override
  final int typeId = 1;

  @override
  ChatMessageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatMessageModel(
      fields[1] as bool,
      fields[0] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ChatMessageModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.isBot)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.userName)
      ..writeByte(4)
      ..write(obj.channelID)
      ..writeByte(5)
      ..write(obj.chatID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatMessageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
