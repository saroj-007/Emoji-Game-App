import 'package:http/http.dart' as http;
import 'package:providerapp/model/apimodel.dart';
//import 'package:smileapp/model/apimodel.dart';
//import 'package:smileapp/model/callapi.dart';
import 'dart:convert';

class SmileyApi {

  String url = "http://marcconrad.com/uob/smile/api.php?out=json";

  // Function to get json data from the web api link
  Future<SmileyModel> getDatas() async {

    // http request to get json reponse from url
    final response = await http.get(Uri.parse(url));

    // check network connection condition for getting json reponse body
    if (response.statusCode == 200){

      // Decode json body 
       return SmileyModel.fromJson(jsonDecode(response.body));
       }
       else{
        throw Exception("Failed to load data");
       }
  }

}