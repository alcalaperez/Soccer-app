class Response<T> {
  Status status;
  T data;
  String message;
  double progress;

  Response.loading(this.message) : status = Status.LOADING;
  Response.loadingProgress(this.message, this.progress)
      : status = Status.LOADING_PROGRESS;
  Response.completed(this.data) : status = Status.COMPLETED;
  Response.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, LOADING_PROGRESS, COMPLETED, ERROR }
