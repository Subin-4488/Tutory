import 'dart:convert';
import 'dart:math';
import 'package:html_character_entities/html_character_entities.dart';
import 'package:http/http.dart';
import 'package:tutory/screens/home/user/Models/question.dart';

class Api {
  List<Question> questions = [];
  Api() {}
  Future<List<Question>> getQuestions() async {
    String url = "https://opentdb.com/api.php?amount=11&category=18&type=multiple";

    Response response = await (get(Uri.parse(url)));
    List<Map<String, dynamic>> question =
        List<Map<String, dynamic>>.from(json.decode(response.body)["results"]);
    return Question.fromData(question);
  }

  Future<List<Question>> startQuiz() async {
    try {
      questions = await getQuestions();
      setValue();
      return questions;
    } catch (e) {
      print(e);
    }
    return questions;
  }

  void setValue() {
    for (int j = 0; j < 11; j++) {
      questions[j]
          .incorrectAnswers
          .insert(Random().nextInt(4), questions[j].correctAnswer);

      for (int u = 0; u < 4; u++) {
        questions[j].incorrectAnswers[u] =
            HtmlCharacterEntities.decode(questions[j].incorrectAnswers[u]);
      }
    }
  }
}
