import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/model/book_model.dart';

class ApiServices {
  static Future<BookDetails> fetchProducts() async {
    var response = await http
        .get(Uri.parse("https://www.googleapis.com/books/v1/volumes?q=http"));

    if (response.statusCode == 200) {
      return BookDetails.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  static Future<BookDetails> fetchProductsUsingId(String id) async {
    var response = await http
        .get(Uri.parse("https://www.googleapis.com/books/v1/volumes?q=$id"));

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
        .post(Uri.parse("https://jsonplaceholder.typicode.com/posts"),
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
