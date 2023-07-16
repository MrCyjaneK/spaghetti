import 'dart:convert';
import 'dart:io';

import 'package:filesize/filesize.dart';
import 'package:shelf_multipart/form_data.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_multipart/multipart.dart';
import 'package:path/path.dart' as p;
import 'package:spaghettiserver/helpers/diskfree.dart';
import 'package:spaghettiserver/server.dart';
import 'package:spaghettiserver/store.dart';

rootHandler(Request request) async {
  if (request.headers["user-agent"]
      .toString()
      .toLowerCase()
      .startsWith("wget/")) {
    return Response.ok('''
░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░░░      ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░   ░░░░░   ░░░░░░░
▒   ▒▒▒▒   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒   ▒▒▒▒  ▒
▒▒   ▒▒▒▒▒▒▒  ▒   ▒▒▒▒▒▒   ▒▒▒▒▒▒     ▒▒▒   ▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒    ▒  ▒    ▒  ▒▒▒▒▒
▓▓▓▓   ▓▓▓▓▓  ▓▓   ▓▓▓   ▓▓   ▓▓   ▓▓   ▓     ▓▓▓▓▓  ▓▓▓   ▓▓▓▓   ▓▓▓▓▓   ▓▓▓   ▓
▓▓▓▓▓▓▓   ▓▓  ▓▓▓   ▓   ▓▓▓   ▓▓  ▓▓▓   ▓   ▓▓  ▓▓         ▓▓▓▓   ▓▓▓▓▓   ▓▓▓   ▓
▓   ▓▓▓▓   ▓   ▓   ▓▓   ▓▓▓   ▓▓    ▓   ▓  ▓▓▓   ▓  ▓▓▓▓▓▓▓▓▓▓▓   ▓ ▓▓▓   ▓ ▓   ▓
███      ███   ████████   █    █████   ██  ███   ███     ███████   █████   ██   █
████████████   ███████████████████    ███████████████████████████████████████████

Spaghetti does not support Wget - beacuse wget does not support multipart/form-data

''');
  }
  if (request.headers["user-agent"].toString().startsWith("curl/")) {
    return Response.ok('''#!/bin/sh
# To upload:
# \$ curl -F 'file=@FILENAME' ${request.headers["host"]}
# fancy oneliner:
# \$ sh <(curl ${request.headers["host"]}) filename.bin
if [[ "x\$1" == "x" ]];
then
echo "Usage: sh <(curl ${request.headers["host"]}) filename.bin";
exit 1;
fi

curl -F "file=@\$1" ${request.headers["host"]};
''');
  }
  final disk = await getDiskSpace(datapath);
  return Response.ok(
    '''
░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░░░      ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░   ░░░░░   ░░░░░░░
▒   ▒▒▒▒   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒   ▒▒▒▒  ▒
▒▒   ▒▒▒▒▒▒▒  ▒   ▒▒▒▒▒▒   ▒▒▒▒▒▒     ▒▒▒   ▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒    ▒  ▒    ▒  ▒▒▒▒▒
▓▓▓▓   ▓▓▓▓▓  ▓▓   ▓▓▓   ▓▓   ▓▓   ▓▓   ▓     ▓▓▓▓▓  ▓▓▓   ▓▓▓▓   ▓▓▓▓▓   ▓▓▓   ▓
▓▓▓▓▓▓▓   ▓▓  ▓▓▓   ▓   ▓▓▓   ▓▓  ▓▓▓   ▓   ▓▓  ▓▓         ▓▓▓▓   ▓▓▓▓▓   ▓▓▓   ▓
▓   ▓▓▓▓   ▓   ▓   ▓▓   ▓▓▓   ▓▓    ▓   ▓  ▓▓▓   ▓  ▓▓▓▓▓▓▓▓▓▓▓   ▓ ▓▓▓   ▓ ▓   ▓
███      ███   ████████   █    █████   ██  ███   ███     ███████   █████   ██   █
████████████   ███████████████████    ███████████████████████████████████████████

# What is "Spaghetti"?
Spaghetti is a simple file pastebin service that you are free to use.

# What are the file limits

Maximum upload size is 1% of whatever is available at the default
store location.
Files are deleted 14 days after last access date. Or 32 days since
they were created.

Used: ${filesize(disk.usedSpace)} / ${filesize(disk.totalSize)}
Max file size: ${filesize((disk.availableSpace * 0.01).toInt())}

# How do I upload?

\$ curl -F 'file=@FILENAME' ${request.headers["host"]}
/<sid>

# How do I download?

\$ wget ${request.headers["host"]}/<sid> -O file_name.bin

# How do I get help?

\$ curl ${request.headers["host"]}

----------

${JsonEncoder.withIndent('    ').convert(request.headers)}

''',
    headers: {"Content-Type": "text/plain"},
  );
}

downloadHandler(Request request, String sid) async {
  try {
    final id = FileStore.idToInt(sid);
    final fs = fileStoreBox.getAt(id);
    if (fs == null) {
      return Response.notFound("404: file not found");
    }
    final file = File(p.join(datapath, "files", FileStore.idToString(id)));
    if (!(await file.exists())) {
      return Response.notFound("404: file gone!");
    }
    return Response.ok(file.openRead(), headers: {
      "Content-Disposition": 'attachment; filename="${fs.filename}"',
      "Content-Type": 'application/octet-stream',
    });
  } catch (e) {
    return Response.internalServerError(body: "something went wrong.");
  }
}

uploadHandler(Request request) async {
  if (!request.isMultipart) {
    return Response.ok('Not a multipart request');
  } else if (request.isMultipartForm) {
    final id = await fileStoreBox.add(FileStore(filename: "file.bin"));
    final elm = fileStoreBox.getAt(id);
    if (elm == null) {
      return Response.internalServerError(
        body: "something went wrong - element is not at the database",
      );
    }
    elm.id = id;
    fileStoreBox.putAt(id, elm);

    if (!(await Directory(p.join(datapath, "files")).exists())) {
      await Directory(p.join(datapath, "files")).create();
    }
    final filew = File(
      p.join(datapath, "files", FileStore.idToString(id)),
    ).openWrite();

    await for (final formData in request.multipartFormData) {
      if (formData.filename != null) {
        final elm = fileStoreBox.getAt(id);
        if (elm == null) {
          return Response.internalServerError(
            body: "something went wrong - element is not at the database",
          );
        }
        elm.filename = formData.filename!;
        fileStoreBox.putAt(id, elm);
      }
      filew.add(await formData.part.readBytes());
    }

    return Response.ok("/${FileStore.idToString(id)}");
  }
}
