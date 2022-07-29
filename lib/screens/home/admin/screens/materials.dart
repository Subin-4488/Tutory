import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tutory/models/materialmodel.dart';
import 'package:tutory/services/database.dart';
import 'package:tutory/shared/loading.dart';
import 'package:tutory/shared/textformfielddecorator.dart';

class Materials extends StatefulWidget {
  const Materials({Key? key}) : super(key: key);

  @override
  State<Materials> createState() => _MaterialsState();
}

class _MaterialsState extends State<Materials> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // TODO: implement build
    return loading
        ? LoadingShared()
        : Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(18),
            child: SingleChildScrollView(
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
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
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
            ),
          );
  }

  Widget generateCard(double width, AssetImage img, int select) {
    String _topic = '';
    String _subtopic = '';
    String _content = '';
    String _grive = '';
    final _key = GlobalKey<FormState>();

    return Card(
      elevation: 2.5,
      color: Theme.of(context).brightness == Brightness.light
          ? Color.fromARGB(223, 255, 255, 255)
          : Color.fromARGB(255, 196, 231, 57),
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

          showDialog(
              context: context,
              builder: (context) {
                return Material(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: Form(
                          key: _key,
                          child: Column(
                            children: [
                              TextFormField(
                                initialValue: topic,
                                validator: ((value) {
                                  if (value!.length <= 0) return 'Enter Field';
                                }),
                                onChanged: (txt) {
                                  _topic = txt;
                                },
                                decoration: TextFormFieldDecorator()
                                    .getDecorator('Topic name'),
                              ),
                              const Expanded(
                                flex: 0,
                                child: SizedBox(
                                  height: 20,
                                ),
                              ),
                              TextFormField(
                                onChanged: (txt) {
                                  _subtopic = txt;
                                },
                                decoration: TextFormFieldDecorator()
                                    .getDecorator('Sub topic name (optional)'),
                              ),
                              const Expanded(
                                flex: 0,
                                child: SizedBox(
                                  height: 20,
                                ),
                              ),
                              Container(
                                height: 280,
                                child: SingleChildScrollView(
                                  child: TextFormField(
                                    keyboardType: TextInputType.multiline,
                                    validator: ((value) {
                                      if (value!.length <= 0)
                                        return 'Enter Field';
                                    }),
                                    onChanged: (txt) {
                                      _content = txt;
                                    },
                                    decoration: TextFormFieldDecorator()
                                        .getDecorator('Content'),
                                    minLines: 10,
                                    maxLines: 35,
                                  ),
                                ),
                              ),
                              const Expanded(
                                flex: 0,
                                child: SizedBox(
                                  height: 20,
                                ),
                              ),
                              TextFormField(
                                onChanged: (txt) {
                                  _grive = txt;
                                },
                                decoration: TextFormFieldDecorator()
                                    .getDecorator('Gdrive (optional)'),
                              ),
                              const Expanded(
                                flex: 0,
                                child: SizedBox(
                                  height: 20,
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    if (_key.currentState!.validate()) {
                                      Navigator.pop(context);
                                      setState(() {
                                        loading = !loading;
                                      });
                                      await Database(uid: '').addMaterials(
                                          MaterialModel(
                                              id: '',
                                              topic: _topic.length>0?_topic:topic,
                                              subtopic: _subtopic,
                                              content: _content,
                                              grive: _grive));
                                      setState(() {
                                        loading = !loading;
                                      });
                                      Fluttertoast.showToast(msg: 'Material added successfully');
                                    }
                                  },
                                  child: const Text('Submit'))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
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
