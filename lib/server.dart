import 'dart:io';

import 'package:hive/hive.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:path/path.dart' as p;
import 'package:spaghettiserver/handlers.dart';
import 'package:spaghettiserver/store.dart';

late final String fileStore;
late final Box<FileStore> fileStoreBox;
late final String datapath;

Future<void> start(String newDatapath, String listenip, int listenport,
    int expiresoft, int expirehard) async {
  datapath = newDatapath;
  Hive.init(p.join(datapath, "objectbox"));
  Hive.registerAdapter(FileStoreAdapter());
  fileStoreBox = await Hive.openBox<FileStore>('fileStore');
  var app = Router();

  app.post('/', uploadHandler);
  app.get('/', rootHandler);
  app.get('/<sid>', downloadHandler);

  var server = await io.serve(app, listenip, listenport);
  cleanup(expiresoft, expirehard);
  print("app started: ${server.address}:${server.port}");
}

Future<void> cleanup(int expiresoft, int expirehard) async {
  for (var fsi in fileStoreBox.values) {
    if (DateTime.now().difference(fsi.accessDate).inSeconds >
            Duration(hours: 24 * expiresoft).inSeconds ||
        DateTime.now().difference(fsi.createdData).inSeconds >
            Duration(hours: 24 * expirehard).inSeconds) {
      final f = File(
        p.join(datapath, "files", FileStore.idToString(fsi.id)),
      );
      if (await f.exists()) {
        await f.delete();
        fsi.exists = false;
        fileStoreBox.putAt(fsi.id, fsi);
      }
    }
  }

  await Future.delayed(Duration(minutes: 37));
  cleanup(expiresoft, expirehard);
}
