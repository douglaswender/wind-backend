import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class AppHandler {
  Handler get handler {
    final app = Router();

    // PRIMEIRA ROTA
    // https://localhost:8080/
    app.get('/', (Request req) {
      return Response(200, body: 'primeira rota');
    });

    // PATH PARAMS
    // /user/user
    app.get('/user/<user>', (Request request, String user) {
      return Response.ok('hello $user');
    });

    // QUERY PARAMS
    // /query?user=Douglas
    app.get('/query', (Request request) async {
      String? user = request.url.queryParameters['user'];
      return Response.ok('Query é: $user', headers: {
        'Content-Type': 'text/plain',
      });
    });

    app.post('/login', (Request request) async {
      final result = await request.readAsString();

      final json = jsonDecode(result);

      if (json['username'] == 'admin' && json['password'] == 'admin') {
        String jsonResponse = jsonEncode({
          'token': 'token123',
          'user_id': 1,
        });
        return Response.ok(jsonResponse,
            headers: {'content-type': 'application/json'});
      } else {
        return Response.forbidden('Acesso negado!');
      }
    });

    return app;
  }
}
