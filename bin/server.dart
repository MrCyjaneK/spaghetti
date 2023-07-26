import 'package:spaghettiserver/server.dart' as server;
import 'package:args/args.dart';

void main(List<String> arguments) async {
  var parser = ArgParser();
  parser.addOption(
    'datapath',
    help: 'Where to store data? e.g. /var/lib/spaghetti',
  );
  parser.addOption('listenip', help: 'Listen ip', defaultsTo: '0.0.0.0');
  parser.addOption('listenport', help: 'Listen port?', defaultsTo: '8080');
  parser.addOption('expiresoft',
      help: 'When to expire (in days since last access)', defaultsTo: '7');
  parser.addOption('expirehard',
      help: 'When to expire (in days since upload)', defaultsTo: '32');
  var results = parser.parse(arguments);

  if (results['datapath'] == null) {
    print(parser.usage);
    return;
  }

  await server.start(
    results['datapath'],
    results["listenip"],
    int.parse(results["listenport"]),
    int.parse(results['expiresoft']),
    int.parse(results['expirehard']),
  );
}
