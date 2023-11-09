enum StateStatusEnum {
  initial,
  loading,
  success,
  error,
}

class StateStatus {
  StateStatusEnum status;
  String? message;
  Map<String, dynamic>? payload;

  StateStatus({required this.status, this.message, this.payload});

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

  static StateStatus error({
    String? message,
    Map<String, dynamic>? payload,
  }) {
    return StateStatus(
      status: StateStatusEnum.error,
      message: message,
      payload: payload,
    );
  }
}
