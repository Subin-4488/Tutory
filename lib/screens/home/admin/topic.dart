import 'package:flutter/material.dart';
import 'package:tutory/screens/home/admin/addquestions.dart';

class Topic extends StatefulWidget {
  const Topic({Key? key}) : super(key: key);

  @override
  State<Topic> createState() => _TopicState();
}

class _TopicState extends State<Topic> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          SizedBox(
            height: size.height / 8.5,
          ),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              generateCard(size.width,
                  const AssetImage('assets/images/crops.png'), 'Agriculture'),
              generateCard(
                  size.width,
                  const AssetImage('assets/images/entertainment.png'),
                  'Entertainment'),
              const Expanded(child: SizedBox()),
            ],
          ),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              generateCard(size.width, const AssetImage('assets/images/gk.png'),
                  '  General\nKnowledge'),
              generateCard(size.width,
                  const AssetImage('assets/images/history.png'), 'History'),
              const Expanded(child: SizedBox()),
            ],
          ),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              generateCard(size.width, const AssetImage('assets/images/gk.png'),
                  'Foreign Affairs'),
              generateCard(size.width,
                  const AssetImage('assets/images/history.png'), 'Economy'),
              const Expanded(child: SizedBox()),
            ],
          )
        ],
      ),
    );
  }

  Widget generateCard(double width, AssetImage img, String topic) {
    return Card(
      color: Color.fromARGB(255, 227, 224, 224),
      child: Container(
        alignment: Alignment.center,
        height: 150,
        width: width / 2.5,
        child: InkWell(
          splashColor: Colors.deepPurple,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddQuestions();
            }));
          },
          child: Column(
            children: [
              Container(
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        alignment: Alignment.topCenter,
                        image: img,
                        fit: BoxFit.contain),
                  )),
              Text(topic,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );
  }
}
