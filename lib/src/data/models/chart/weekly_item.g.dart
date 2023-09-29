// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeeklyItemAdapter extends TypeAdapter<WeeklyItem> {
  @override
  final int typeId = 3;

  @override
  WeeklyItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeeklyItem(
      name: fields[0] as String,
      qty: fields[1] as String,
      price: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WeeklyItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.qty)
      ..writeByte(2)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeeklyItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WeeklyItemsAdapter extends TypeAdapter<WeeklyItems> {
  @override
  final int typeId = 4;

  @override
  WeeklyItems read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeeklyItems(
      items: (fields[3] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<WeeklyItem>())),
    );
  }

  @override
  void write(BinaryWriter writer, WeeklyItems obj) {
    writer
      ..writeByte(1)
      ..writeByte(3)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeeklyItemsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
