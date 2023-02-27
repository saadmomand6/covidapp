import 'dart:convert';

import 'package:covidapp/apiurl.dart';
import 'package:covidapp/model/worldstatesmodel.dart';
import 'package:http/http.dart' as http;


class Network{
  Future<Worldstatesmodel> getdata() async{

    http.Response response = await http.get(Uri.parse(ApiUrls.worldstates));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());

      return Worldstatesmodel.fromJson(data);
      
    }else{
      throw Exception('Error');
    }

  }
  Future<List<dynamic>> getcountriesdata() async{
    
    http.Response response = await http.get(Uri.parse(ApiUrls.countrylist));

    if (response.statusCode == 200) {
    var   data = jsonDecode(response.body.toString());

      return data;
      
    }else{
      throw Exception('Error');
    }

  }
}