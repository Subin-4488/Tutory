class Question {
  final String id;
  final String topic;
  final String question;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final int year;
  final String ans;

  Question(
      {
      required this.id,
      required this.topic,
      required this.ans,
      required this.question,
      required this.option1,
      required this.option2,
      required this.option3,
      required this.option4,
      required this.year});
}
