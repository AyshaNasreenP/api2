import 'dart:convert';

import 'package:api2/models/bored.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class api2 extends StatefulWidget {
  const api2({super.key});

  @override
  State<api2> createState() => _api2State();
}

class _api2State extends State<api2> {

  Future<bored> boredDetails() async {
    var resp= await http.get(Uri.parse("https://www.boredapi.com/api/activity"));
    return bored.fromJson(jsonDecode(resp.body));
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: boredDetails(),
          builder: (context,snapshot)
          {
             if(snapshot.hasData)
            {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(snapshot.data!.activity.toString()),
                Text(snapshot.data!.price.toString()),
                Text(snapshot.data!.participants.toString()),
                Text(snapshot.data!.accessibility.toString())
              ],
              );
          }
             else if(snapshot.hasError){
               return Text("${snapshot.error}");
             }
             return CircularProgressIndicator();
    },
      )
    );
  }
}
