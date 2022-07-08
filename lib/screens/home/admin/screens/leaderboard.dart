import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tutory/models/leaders.dart';
import 'package:tutory/services/database.dart';
import 'package:tutory/shared/loading.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  bool load = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 9,
            ),
            const Text(
              'Remove User',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height / 25,
            ),
            Container(
              margin:
                  EdgeInsets.only(left: size.width / 7, right: size.width / 20),
              child: Row(
                children: [
                  const Expanded(
                      child: Text(
                    'Email',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
                  Row(
                    children: const [
                      Text('Score',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage('assets/images/Badge.png')),
                        )),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.height / 60,
            ),
            Container(
              child: load
                  ? const LoadingShared()
                  : Container(
                      height: size.height / 1.4,
                      decoration: BoxDecoration(
                          border: Border.all(width: .2),
                          borderRadius: BorderRadius.circular(15)),
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(
                          left: size.width / 12, right: size.width / 18),
                      child: StreamBuilder(
                          stream: Database(uid: '').getLeaderboard,
                          builder: ((context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              List<Leaders> list =
                                  snapshot.data!.docs.map((DocumentSnapshot e) {
                                return Leaders(
                                    email: e.get('email'),
                                    score: e.get('score'),
                                    uid: e.get('uid'));
                              }).toList();
                              return snapshot.hasData
                                  ? ListView.builder(
                                      itemCount: snapshot.data!.size,
                                      itemBuilder: ((context, index) {
                                        return Material(
                                          child: Card(
                                            elevation: 0.6,
                                            child: ListTile(
                                              leading: const SizedBox(
                                                height: 30,
                                                width: 30,
                                                child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.contain,
                                                      image: AssetImage(
                                                          'assets/images/Avatar.png')),
                                                )),
                                              ),
                                              title: Text(
                                                list[index].email,
                                                
                                              ),
                                              trailing: Text(
                                                list[index].score,
                                                style: TextStyle(
                                                  color: HexColor('#EEE513'),
                                                ),
                                              ),
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return SimpleDialog(
                                                        title: Text(
                                                            'Do you want to remove ${list[index].email}'),
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            15),
                                                                child:
                                                                    ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(
                                                                            primary: Colors
                                                                                .red),
                                                                        onPressed:
                                                                            () async {
                                                                          setState(
                                                                              () {
                                                                            load =
                                                                                true;
                                                                            Database(uid: list[index].uid).deleteUser();
                                                                            load =
                                                                                false;
                                                                            Fluttertoast.showToast(
                                                                                toastLength: Toast.LENGTH_LONG,
                                                                                msg: 'User deleted successfully');
                                                                            Navigator.of(context).pop();
                                                                          });
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          'Remove',
                                                                        )),
                                                              ),
                                                              const Expanded(
                                                                  child:
                                                                      SizedBox()),
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            15),
                                                                child:
                                                                    ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(
                                                                            primary: Colors
                                                                                .green),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: const Text(
                                                                            'Cancel')),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      );
                                                    });
                                              },
                                            ),
                                          ),
                                        );
                                      }))
                                  : const Center(
                                      child: LoadingShared(),
                                    );
                            }
                            return const Center(
                              child: LoadingShared(),
                            );
                          })),
                    ),
            ),
          ],
        ));
  }
}
