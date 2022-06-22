import 'package:flutter/material.dart';

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
      child: Column(
        children: [
          SizedBox(height: 20,),
          row(const AssetImage('assets/images/back.png'),'Agriculture'),
        ],
      ),
    );
  }

  Widget row(AssetImage img,String topic){
    return Card(
      child: Container(
        alignment: Alignment.center,
        height: 150,
        width: 150,
        child: Stack(
          children: [
            DecoratedBox(decoration: BoxDecoration(
              image: DecorationImage(image: img,fit: BoxFit.contain),
            )),
            Text(topic),
          ],
        ),
      ),
    );
  }
}
