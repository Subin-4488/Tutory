import 'package:flutter/material.dart';
import 'package:tutory/screens/home/admin/screens/questions.dart';

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
          Container(
            margin: EdgeInsets.only(left: size.width / 25),
            alignment: Alignment.centerLeft,
            child: const Text(
              'CHOOSE TOPIC',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: size.height / 40,
          ),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              generateCard(
                  size.width, const AssetImage('assets/images/gate.png'), 0),
              generateCard(
                  size.width, const AssetImage('assets/images/jee.png'), 1),
              const Expanded(child: SizedBox()),
            ],
          ),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              generateCard(
                  size.width, const AssetImage('assets/images/neet.png'), 2),
              generateCard(
                  size.width, const AssetImage('assets/images/ssb.png'), 3),
              const Expanded(child: SizedBox()),
            ],
          ),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              generateCard(
                  size.width, const AssetImage('assets/images/upsc.png'), 4),
              generateCard(
                  size.width, const AssetImage('assets/images/upsc.png'), 5),
              const Expanded(child: SizedBox()),
            ],
          )
        ],
      ),
    );
  }

  Widget generateCard(double width, AssetImage img, int select) {
    return Card(
      elevation: 2.5,
      color: Theme.of(context).brightness==Brightness.light?
       Color.fromARGB(223, 255, 255, 255):
       Color.fromARGB(255, 57, 231, 216),
      child: InkWell(
        splashColor: const Color.fromARGB(255, 203, 203, 203),
        onTap: () {
          int year = 2014;

          String topic;
          select == 0
              ? topic = 'Gate'
              : select == 1
                  ? topic = 'Jee'
                  : select == 2
                      ? topic = 'Neet'
                      : select == 3
                          ? topic = 'Ssb'
                          : topic = 'Upsc';

          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  child: ListView.builder(
                      itemCount: 8,
                      itemBuilder: ((context, index) {
                        return Card(
                          elevation: 1.5,
                          child: Material(
                            child: ListTile(
                              iconColor: Color.fromARGB(255, 255, 0, 0),
                              leading: const Icon(Icons.book),
                              title: Text(
                                '${topic} ${index + year}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              trailing: const Icon(Icons.arrow_right),
                              onTap: ((){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Questions(
                                  topic: topic,
                                  year: year+index,
                                );
                              }));
                              }),
                            ),
                          ),
                        );
                      })),
                );
              });
        },
        child: Container(
          alignment: Alignment.center,
          height: 140,
          width: width / 2.5,
          child: Container(
              margin: const EdgeInsets.only(top: 20, bottom: 10),
              height: 80,
              decoration: BoxDecoration(
                image: DecorationImage(image: img, fit: BoxFit.contain),
              )),
        ),
      ),
    );
  }
}
