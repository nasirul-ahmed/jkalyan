class ApiResponse<T> {
  T? data;
  bool? err;
  String? errorMsg;

  ApiResponse({
    this.data,
    this.err = false,
    this.errorMsg,
  });
}
