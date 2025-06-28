extension ExceptionExtension on Exception {
  String get message {
    return toString().replaceAll('Exception: ', '');
  }
}
