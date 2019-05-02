import 'package:dio/dio.dart';

class Api_Call {
  Dio _dio;

  static final baseUrl = "https://jsonplaceholder.typicode.com";

  Future<Dio> get dio async {
    if (_dio == null) {
      _dio = await _initApi();
    }
    return _dio;
  }

  _initApi() async {
    var theDio = Dio(BaseOptions(baseUrl: baseUrl));
    return theDio;
  }

  String _handleError(DioError err) {
    String errorMessage = "";
    switch (err.type) {
      case DioErrorType.DEFAULT:
        errorMessage = "Check your internet Connection";
        break;
      case DioErrorType.CANCEL:
        errorMessage = "";
        break;
      default:
        errorMessage = "Something Wrong";
        break;
    }
    return errorMessage;
  }

  getUsers(Function(List<dynamic>) onSuccess, Function(String) onError) async {
    try {
      var resClient = await dio;
      Response response = await resClient.get("/posts");
      onSuccess(response.data);
    } on DioError catch (err) {
      onError(_handleError(err));
      print(err);
    }
  }
}

---------------------------------------------------

 Api_Call _api_call = Api_Call();
  List<dynamic> _list = List();

 @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    _api_call.getUsers((data) {
      if (!mounted) return;
      if (data != null) {
        setState(() {
          _list.addAll(data as List);
          _visible = false;
        });
      }
    }, (err) {
      print(err);
    });
  }
