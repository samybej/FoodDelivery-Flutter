class ResponseModel {
  final bool _isSuccessful;
  final String _message;

  String get message => _message;
  bool get isSuccessful => _isSuccessful;

  ResponseModel(this._isSuccessful, this._message);
}
