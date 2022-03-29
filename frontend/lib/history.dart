import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/user_info.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserInfo>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
      ),
      body: historyWidget(userInfo.getUserId),
    );
  }

  Widget historyWidget(String userId) {
    return FutureBuilder(
      future: retrieveHistory(userId),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List history = snapshot.data ?? [];
        if (history.isNotEmpty) {
          return ListView(
            padding: const EdgeInsets.only(top: 15),
            scrollDirection: Axis.vertical,
            children: history
                .map(
                  (h) => Column(
                    children: <Widget>[
                      ListTile(
                        subtitle: Text(h),
                      ),
                      const Divider(
                        color: Colors.black,
                        height: 20,
                        thickness: 1,
                        indent: 20,
                        endIndent: 40,
                      ),
                    ],
                  ),
                )
                .toList(),
          );
        } else {
          return const Center(
            child: Text("No History"),
          );
        }
      },
    );
  }

  Future<List> retrieveHistory(String userId) async {
    List history = [];

    // This is an open REST API endpoint for testing purposes
    var url =
        Uri.parse('https://signify-10529.uc.r.appspot.com/history?id=$userId');

    final http.Response response = await http.get(url);
    history = jsonDecode(response.body)['history'];

    return history;
  }
}
