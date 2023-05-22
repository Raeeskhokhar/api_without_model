import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var data;
  Future<void> getuserapi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api Without Model'),
        centerTitle: true,
      ),
      body: Column(children: [
        Expanded(
          child: FutureBuilder(
            future: getuserapi(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('laoding');
              } else {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          ResusableRow("Name:-", data[index]["name"]),
                          ResusableRow("Email:-", data[index]["email"]),
                          ResusableRow("Username:-", data[index]["username"]),
                          ResusableRow(
                              "Adress:-", data[index]["address"]["geo"]["lat"]),
                          ResusableRow("Name:-", data[index]["name"]),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        )
      ]),
    );
  }
}

class ResusableRow extends StatelessWidget {
  String title = '';
  String value = '';
  ResusableRow(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
//  var data;
//   Future<void> getuserapi() async {
//     final response =
//         await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
//     if (response.statusCode == 200) {
//       data = jsonDecode(response.body.toString());
//     } else {}
//   }
// ===============================

// Expanded(
//             child: FutureBuilder(
//           future: getuserapi(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Text('Loading');
//             } else {
//               return ListView.builder(
//                 itemCount: data.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     child: Column(children: [
//                       ResusableRow('Name:- ', data[index]["name"].toString()),
//                       ResusableRow(
//                           'Username:- ', data[index]["username"].toString()),
//                       ResusableRow('Email:- ', data[index]["email"].toString()),
//                       ResusableRow('Address:- ',
//                           data[index]["address"]["city"].toString()),
//                       ResusableRow('Geo:- ',
//                           data[index]["address"]["geo"]["lat"].toString()),
//                     ]),
//                   );
//                 },
//               );
//             }
//           },
//         ))
//  ==============================
// class ResusableRow extends StatelessWidget {
//   String title = '';
//   String value = '';
//   ResusableRow(this.title, this.value);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [Text(title), Text(value)],
//       ),
//     );
//   }
// }
