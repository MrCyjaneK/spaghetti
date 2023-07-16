import 'dart:io';

import 'package:universal_disk_space/universal_disk_space.dart';

Future<Disk> getDiskSpace(String path) async {
  final diskSpace = DiskSpace();
  await diskSpace.scan();
  var homeDisk = diskSpace.getDisk(Directory('path'));
  return homeDisk;
}
