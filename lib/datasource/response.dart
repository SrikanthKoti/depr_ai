class Response {
  final dynamic data;
  final bool isSuccess;
  final String errorMsg;

  const Response({this.data, this.isSuccess = true, this.errorMsg = ''});
}
