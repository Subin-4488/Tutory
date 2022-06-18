import 'package:flutter/material.dart';
import 'package:tutory/models/leaders.dart';
import 'package:tutory/services/database.dart';
import 'package:tutory/shared/loading.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Container(
        color: Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            SizedBox(
              height: size.height/9,
            ),
            const Text('LEADERBOARD',
            style: TextStyle(
              fontSize: 20,
              fontWeight:FontWeight.bold
            ),),
            SizedBox(height: size.height/25,),
            Container(
              margin: EdgeInsets.only(left: size.width/6,
              right: size.width/15),
              child: Row(
                children:const  [
                  Expanded(child: Text('Email',style: TextStyle(
                    fontSize: 16,fontWeight: FontWeight.bold
                  ),)),
                  Text('Score',style: TextStyle(
                    fontSize: 16,fontWeight: FontWeight.bold
                  ))
                ],
              ),
              ),
            SizedBox(height: size.height/60,),
            Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(left: size.width/8),
                child: FutureBuilder(
                    future: Database(uid: '0').getLeaderboard(),
                    builder: ((context, AsyncSnapshot<List<Leaders>?> snapshot) {
                      List<Leaders>? list = snapshot.data;
                          
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(itemCount: list!.length,itemBuilder: ((context, index) {
                          if (snapshot.hasData) {
                            return Card(
                              child: ListTile(
                                leading: Text('${list[index].name}',
                                style: TextStyle(
                                  color: Color(0x2A1E17)
                                ),),
                                trailing: Text('Score: ${list[index].score}',
                                style: TextStyle(
                                  color: Color.fromARGB(0, 68, 67, 63),
                                ),),
                              ),
                            );
                          }
                          return LoadingShared();
                        }));
                      } else {
                        return Center(child: LoadingShared());
                      }
                    })),
              ),
            ),
          ],
       