import 'package:flutter/material.dart';
import 'package:tutory/screens/home/user/pages/online/onlineQuiz.dart';

class Competition extends StatefulWidget {
  const Competition({Key? key}) : super(key: key);

  @override
  State<Competition> createState() => _CompetitionState();
}

class _CompetitionState extends State<Competition> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              //color of border
              color: Colors.transparent,
              width: 60, //width of border
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: ((context) {
                    return OnlineQuiz();
                  })));
                },
                child: const Text('Compete online')),
          )),
    );
  }
}
