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
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          SizedBox(height: 20,),
          Row(children: [
            const Expanded(child: SizedBox()), 
            generateCard(size.width,const AssetImage('assets/images/crops.png'),'Agriculture'),
            generateCard(size.width,const AssetImage('assets/images/entertainment.png'),'Entertainment'),
            const Expanded(child: SizedBox()),
          ],)
          
        ],
      ),
    );
  }

  Widget generateCard(double width,AssetImage img,String topic){
    return Card(
      child: Container(
        alignment: Alignment.center,
        height: 120,
        width: width/2.5,     
        child: Stack(
          children: [
            DecoratedBox(decoration: BoxDecoration(
              image: DecorationImage(image: img,fit: BoxFit.contain),
            )),
            Text(topic,style: TextStyle())
          ],
        ),
      ),
    )