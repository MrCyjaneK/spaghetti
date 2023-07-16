import 'package:hive/hive.dart';

part 'store.g.dart';

@HiveType(typeId: 1)
class FileStore {
  FileStore({required this.filename});
  @HiveField(0)
  int id = 0;

  static idToInt(String id) {
    return int.parse(id, radix: 36);
  }

  static idToString(int id) {
    return id.toRadixString(36);
  }

  @HiveField(1)
  DateTime createdData = DateTime.now();

  @HiveField(2)
  DateTime accessDate = DateTime.now();

  @HiveField(3)
  String filename = "file.bin";

  @HiveField(4)
  bool exists = true;
}
