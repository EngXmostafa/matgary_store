abstract class Failure {
  String statusCode;

  String? messageAr;
  String? messageEn;
  String? message;

  Failure({
    required this.statusCode,
     this.messageAr,
     this.messageEn,
     this.message,
  });
}


class ServerException implements Exception {
  final int statusCode;
  final String? message;

  ServerException({
     required this.statusCode,
    this.message,
  });

  @override
  String toString() => 'ServerException($statusCode): $message';
}

