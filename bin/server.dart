import 'package:spaghettiserver/server.dart' as server;
import 'package:args/args.dart';

void main(List<String> arguments) async {
  var parser = ArgParser();
  parser.addOption('datapath');

  var results = parser.parse(arguments);
  await server.start(results['datapath']);
}
