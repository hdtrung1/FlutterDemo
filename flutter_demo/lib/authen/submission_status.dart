abstract class SubmissionStatus {
  const SubmissionStatus();
}

class InitialStatus extends SubmissionStatus {
  const InitialStatus();
}

class Submitting extends SubmissionStatus {}

class SubmissionSuccess extends SubmissionStatus {}

class SubmissionFailure extends SubmissionStatus {
  final Exception exception;

  SubmissionFailure(this.exception);
}