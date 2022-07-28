import 'package:flutter/material.dart';
import 'package:tutory/models/materialmodel.dart';
import 'package:tutory/services/database.dart';
import 'package:tutory/shared/loading.dart';

class ViewMaterial extends StatelessWidget {
  MaterialModel model;
  ViewMaterial({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.topic),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder(
          builder: (context, AsyncSnapshot<List<MaterialModel>> snapshot) {
            if (snapshot.hasData) {
              List<MaterialModel> list = snapshot.data!.map((e) {
                return MaterialModel(
                    id: e.id,
                    topic: e.topic,
                    subtopic: e.subtopic,
                    content: e.content,
                    grive: e.grive);
              }).toList();
                return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(14.0), 
                        child: Card(
                          child: ListTile(
                            title: Column(
                              children: [
                                Text(list[index].subtopic,
                                style: const TextStyle(
                                  color: Colors.deepPurpleAccent,
                                  fontSize: 18 ,
                                  fontWeight: FontWeight.bold,
                                ),),
                                Text(list[index].content),
                                Text(list[index].grive)
                              ],
                            ),
                          ),
                        ),
                      );
                    }));
              
            } else
              return LoadingShared();
          },
          future: Database(uid: '').getMaterials(model),
        ),
      ),
    );
  }
}
