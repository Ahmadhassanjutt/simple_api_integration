import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Map<String, dynamic>? dataMap;
  Map<String, dynamic>? accessDataMap; //for single user
  List<dynamic>? accessDataList;   //for list

  Future getApi() async{
    
    http.Response response;
    response = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));

    if(response.statusCode == 200){
        setState(() {
          dataMap = jsonDecode(response.body);
          accessDataList = dataMap!["data"];
          print(accessDataList);
        });
    }
    
  }

  @override
  void initState() {
    super.initState();
    getApi();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text("Get Api",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
      ),
       body: Center(
         // for list
         child: accessDataList == null ? const CircularProgressIndicator()
        : ListView.builder(
             itemCount: accessDataList!.length,
             itemBuilder: (context, index){
               return  ListTile(
                 leading: CircleAvatar(backgroundImage: NetworkImage(accessDataList![index]["avatar"]),),
                 title: Text("${accessDataList![index]["first_name"]} ${accessDataList![index]["last_name"]}",
                 ),
                 subtitle: Text(accessDataList![index]["email"].toString()),
                  );
         }),
       )

        //for single user
      //  Center(
      //   child: accessDataMap == null ? const CircularProgressIndicator()
      //       : ListTile(
      //     title: Text(
      //         "${accessDataMap!['first_name']} ${accessDataMap!['last_name']}",
      //         ),
      //     subtitle: Text(accessDataMap!['email'].toString()),
      //   )
      // ),
    );
  }
}
