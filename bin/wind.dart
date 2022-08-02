import 'package:shelf/shelf_io.dart' as io;

import 'server_handler.dart';

void main() async {
  final server = AppHandler();

  await io
      .serve(server.handler, 'localhost', 8080)
      .then((value) => print('API running at http://localhost:${value.port}'));
}
