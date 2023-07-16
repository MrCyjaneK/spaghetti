// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FileStoreAdapter extends TypeAdapter<FileStore> {
  @override
  final int typeId = 1;

  @override
  FileStore read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FileStore(
      filename: fields[3].toString(),
    )
      ..id = fields[0] as int
      ..createdData = fields[1] as DateTime
      ..accessDate = fields[2] as DateTime;
  }

  @override
  void write(BinaryWriter writer, FileStore obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdData)
      ..writeByte(2)
      ..write(obj.accessDate)
      ..writeByte(3)
      ..write(obj.filename);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileStoreAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
