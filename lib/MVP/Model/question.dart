class Question{
  final String? question;
  Question({
    this.question
});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        question: json['question']
    );
  }
}