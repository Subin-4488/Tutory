// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../models/leaders.dart';
import '../../../../services/database.dart';
import '../../../../shared/loading.dart';

class Home_Container extends StatefulWidget {
  const Home_Container({Key? key}) : super(key: key);

  @override
  State<Home_Container> createState() => _Home_ContainerState();
}

class _Home_ContainerState extends State<Home_Container> {
  @override
  bool load = false;
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            //color of border
            color: Colors.transparent,
            width: 5, //width of border
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Leaderboard",
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            load
                ? const LoadingShared()
                : Container(
                    height: size.height / 1.4,
                    
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(
                        left: size.width / 12, right: size.width / 18),
                    child: StreamBuilder(
                        stream: Database(uid: '').getLeaderboard,
                        builder:
                            ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                            onTap: () {},
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
          ],
        ),
      ),
    );
  }
}
