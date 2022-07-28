import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tutory/models/materialmodel.dart';
import 'package:tutory/screens/home/user/pages/materials/viewMaterial.dart';

class Study extends StatefulWidget {
  const Study({Key? key}) : super(key: key);

  @override
  State<Study> createState() => _StudyState();
}

class _StudyState extends State<Study> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              //color of border
              color: Colors.transparent,
              width: 50, //width of border
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Material(
            child: Column(
              children: [
                SizedBox(
                  height: size.height / 28.5,
                ),
                Container(
                  //margin: EdgeInsets.only(left: size.width / 25),
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
                    generateCard(size.width,
                        const AssetImage('assets/images/gate.png'), 0),
                    generateCard(size.width,
                        const AssetImage('assets/images/jee.png'), 1),
                    const Expanded(child: SizedBox()),
                  ],
                ),
                Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    generateCard(size.width,
                        const AssetImage('assets/images/neet.png'), 2),
                    generateCard(size.width,
                        const AssetImage('assets/images/ssb.png'), 3),
                    const Expanded(child: SizedBox()),
                  ],
                ),
                Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    generateCard(size.width,
                        const AssetImage('assets/images/upsc.png'), 4),
                    generateCard(size.width,
                        const AssetImage('assets/images/upsc.png'), 5),
                    const Expanded(child: SizedBox()),
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget generateCard(double width, AssetImage img, int select) {
    return Card(
      elevation: 2.5,
      color: Theme.of(context).brightness == Brightness.light
          ? const Color.fromARGB(223, 255, 255, 255)
          : const Color.fromARGB(255, 57, 231, 216),
      child: InkWell(
        splashColor: const Color.fromARGB(255, 203, 203, 203),
        onTap: () {
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

          (select == 0)
              ? showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    List<String> subtopics_gate = [
                      'Stack',
                      'Array',
                      'Linked List',
                      'Hashmap',
                      'Queue',
                      'Object oriented concepts'
                    ];
                    return Container(
                      padding: const EdgeInsets.all(8),
                      child: ListView.builder(
                          itemCount: subtopics_gate.length,
                          itemBuilder: ((context, index) {
                            return Card(
                              child: ListTile(
                                leading: const Icon(Icons.stadium),
                                title: Text(
                                  subtopics_gate[index],
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: (() {
                                  if (select == 0) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: ((context) {
                                      return ViewMaterial(
                                        model: MaterialModel(
                                            id: '',
                                            topic: topic,
                                            subtopic: subtopics_gate[index],
                                            content: '',
                                            grive: ''),
                                      );
                                    })));
                                  }
                                }),
                              ),
                            );
                          })),
                    );
                  })
              : Fluttertoast.showToast(msg: 'No material found');
        },
        child: Container(
          alignment: Alignment.center,
          height: 120,
          width: width / 3.5,
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
