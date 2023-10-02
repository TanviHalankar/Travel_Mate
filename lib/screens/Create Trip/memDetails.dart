import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

import '../../db_info.dart';
import '../../model/members.dart';

class MemberDetails extends StatefulWidget {
  int tripId;
  MemberDetails({Key? key, required this.tripId}) : super(key: key);

  @override
  State<MemberDetails> createState() => _MemberDetailsState();
}

class _MemberDetailsState extends State<MemberDetails> {
  late Future<List<Members>> members;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    members = fetchMembersById(widget.tripId);
  }

  Future<List<Members>> fetchMembersById(int tripId) async {
    final response =
        await http.get(Uri.parse('http://$ip:9000/members/$tripId'));
    if (response.statusCode == 200) {
      final List<dynamic> memDataList = json.decode(response.body);
      return memDataList.map((memData) => Members.fromJson(memData)).toList();
    } else {
      throw Exception('Failed to load members with ID: $tripId');
    }
  }

  Future<void> updateStatus(String memberId, String status, int tripId) async {
    final response = await http.put(
      Uri.parse('http://$ip:9000/members/$memberId/$tripId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'status': status}),
    );

    if (response.statusCode == 200) {
      setState(() {
        members=fetchMembersById(widget.tripId);
      });
    }
  }

  Future<void> deleteMember(String memberId, int tripId) async {
    final response = await http
        .delete(Uri.parse('http://$ip:9000/members/$memberId/$tripId'));

    if (response.statusCode == 200) {
      setState(() {
        members=fetchMembersById(widget.tripId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Members>>(
          future: members,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text('No data available'));
            } else {
              List<Members> membersList = snapshot.data!;
              return membersList.isEmpty
                  ? SizedBox.expand(
                      child:
                          Center(child: Text('No member registrations found!')))
                  : ListView.builder(
                      itemCount: membersList.length,
                      itemBuilder: (context, index) {
                        Members member = membersList[index];
                        return Column(
                          children: [
                            Slidable(
                              // startActionPane: ActionPane(
                              //   motion: const StretchMotion(),
                              //   children: [
                              //     SlidableAction(
                              //       onPressed: (context) {
                              //         deleteMember(member.memberId, member.tripId);
                              //       },
                              //       backgroundColor: Colors.green,
                              //       icon: Icons.corporate_fare_rounded,
                              //       label: 'View',
                              //     )
                              //   ],
                              // ),
                              endActionPane: ActionPane(
                                motion: BehindMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      deleteMember(
                                          member.memberId, member.tripId);
                                      print('deleted');
                                    },
                                    backgroundColor: Colors.red,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  )
                                ],
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.all(16),
                                title: Text('${member.userName}'),
                                subtitle: Text('${member.residence}'),
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                ),
                                trailing: ElevatedButton(
                                  child: member.status == 'pending'
                                      ? Text('Pending')
                                      : Text('Accepted'),
                                  onPressed: () {
                                    updateStatus(member.memberId, 'accept',
                                        member.tripId);
                                  },
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                            )
                          ],
                        );
                      },
                    );
            }
          }),
    );
  }
}
