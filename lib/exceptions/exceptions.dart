class AppExceptions implements Exception {
  @override
  String toString() {
    return "Weight Tracker Related Exception";
  }
}

class InvalidWeightException extends AppExceptions {
  @override
  String toString() {
    return "Weight can never be 0";
  }
}

class InvalidTimeException extends AppExceptions {
  @override
  String toString() {
    return "Please select valid time";
  }
}
