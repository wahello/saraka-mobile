import 'package:saraka/domains.dart';

abstract class Card {
  String get id;

  String get text;

  DateTime get lastLearnedAt;

  DateTime get hasToLearnAfter;

  bool get hasToStudy => hasToLearnAfter.isBefore(DateTime.now());

  Future<void> markLearned(LearningCertainty certainty) async {
    switch (certainty) {
      case LearningCertainty.good:
        return await logLearning(certainty, Duration(minutes: 1));
      case LearningCertainty.vague:
        return await logLearning(certainty, Duration(minutes: 5));
    }
  }

  Future<void> logLearning(LearningCertainty certainty, Duration interval);

  Future<void> undoLearning();

  @override
  operator ==(Object other) => other is Card && other.id == id;

  @override
  int get hashCode => id.hashCode;
}