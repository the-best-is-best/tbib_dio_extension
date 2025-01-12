class Failure {
  final int? statusCode;
  final String? messages;
  final Map<String, dynamic>? error;

  Failure(this.statusCode, this.messages, this.error);
}
