enum StateStatusEnum {
  initial,
  loading,
  success,
  error,
}

class StateStatus {
  StateStatusEnum status;
  String? message;

  StateStatus({
    required this.status,
    this.message,
  });

  static StateStatus initial() {
    return StateStatus(
      status: StateStatusEnum.initial,
    );
  }

  static StateStatus loading() {
    return StateStatus(
      status: StateStatusEnum.loading,
    );
  }

  static StateStatus success() {
    return StateStatus(
      status: StateStatusEnum.success,
    );
  }

  static StateStatus error(String? message) {
    return StateStatus(
      status: StateStatusEnum.error,
      message: message,
    );
  }
}
