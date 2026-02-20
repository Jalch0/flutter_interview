abstract class Failure {
  const Failure({
    required this.message,
  });

  final String message;
}

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
  });
}

class DatabaseFailure extends Failure {
  const DatabaseFailure({
    required super.message,
  });
}
