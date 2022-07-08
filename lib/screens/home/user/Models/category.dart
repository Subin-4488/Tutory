import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category{
  final int id;
  final String name;
  final dynamic icon;
  Category(this.id, this.name, this.icon);

}

final List<Category> categories = [
  Category(9,"General Knowledge", FontAwesomeIcons.globe),
  Category(10,"Books", FontAwesomeIcons.bookOpen),
  Category(11,"Film", FontAwesomeIcons.video),
  Category(12,"Music", FontAwesomeIcons.music),
  Category(13,"Musicals & Theatres", FontAwesomeIcons.film),
  Category(14,"Television", FontAwesomeIcons.tv),
  Category(15,"Video Games", FontAwesomeIcons.gamepad),
  Category(16,"Board Games", FontAwesomeIcons.chessBoard),
  Category(17,"Science & Nature", FontAwesomeIcons.microscope),
  Category(18,"Computer", FontAwesomeIcons.laptopCode),
  Category(19,"Maths", FontAwesomeIcons.plusMinus),
  Category(20,"Mythology",FontAwesomeIcons.bookAtlas),
  Category(21,"Sports", FontAwesomeIcons.football),
  Category(22,"Geography", FontAwesomeIcons.mountain),
  Category(23,"History", FontAwesomeIcons.monument),
  Category(24,"Politics",FontAwesomeIcons.bookBible),
  Category(25,"Art", FontAwesomeIcons.paintbrush),
  Category(26,"Celebrities",FontAwesomeIcons.person),
  Category(27,"Animals", FontAwesomeIcons.dog),
  Category(28,"Vehicles", FontAwesomeIcons.car),
  Category(29,"Comics",FontAwesomeIcons.bookOpen),
  Category(30,"Gadgets", FontAwesomeIcons.mobile),
  Category(31,"Japanese Anime & Manga",FontAwesomeIcons.bookOpen),
  Category(32,"Cartoon & Animation",FontAwesomeIcons.bookOpen),
];