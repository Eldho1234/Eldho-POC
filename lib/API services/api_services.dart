import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/const/consttant.dart';
import 'package:login/model/book_model.dart';

class ApiServices {
  static Future<BookDetails> fetchProducts() async {
    var response = await http
        .get(Uri.parse(getall));

    if (response.statusCode == 200) {
      return BookDetails.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  static Future<BookDetails> fetchProductsUsingId(String id) async {
    var response = await http
        .get(Uri.parse('$getById/$id'));

    if (response.statusCode == 200) {
      return BookDetails.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  static Future<bool> login(String email, String password) async {
    Map<String, dynamic> postData = {
      'title': email,
      'body': password,
      'userId': 1,
    };
    final response = await http
        .post(Uri.parse(postUser),
        headers: {'Content-Type':'application/json'},
        body: jsonEncode(postData)
        );
    if(response.statusCode==201){
      return true;
    }else{
      return false;
    }    
  }
}
