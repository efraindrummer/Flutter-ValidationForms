import 'dart:convert';

import 'package:http/http.dart' as http;

class UsuarioProvider{

  final String _firebaseToken = 'AIzaSyBm3DTOW4gdluBdGqbEjh4wMl37Mn-NhoY';

  Future nuevoUsuario(String email, String password) async{

    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if(decodedResp.containsKey('idToken')){
      //salvar el token en el storage
      return {'ok': true, 'token': decodedResp['idToken']};
    }else{
      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }
}