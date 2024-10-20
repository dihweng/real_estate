import 'package:dio/dio.dart';
import '../locator.dart';
import '../services/api_services.dart';
import '../utils/local_store.dart';
import 'base_model.dart';

//Callback function type to show user password alert
typedef ShowAlertCallback = void Function(String message);

class AuthViewModel extends BaseViewModel {
  final ApiService _apiService = locator<ApiService>();
  // final AuthService _authService = locator<AuthService>();
  LocalStoreHelper localStoreHelper = LocalStoreHelper();

  // Future<dynamic> login(String userName, String password) async {
  //   setStatus(ViewStatus.Loading);
  //   Response? response;
  //   try {
  //     response = await _authService.verifyUser(userName, password);
  //     if (response.statusCode! >= 200 && response.statusCode! <= 300) {
  //       setStatus(ViewStatus.Success);
  //       final String token = response.data['token'];
  //       _apiService.setToken(token);
  //       await LocalStoreHelper.saveInfo(token);
  //       // final Map<String, dynamic> data =
  //       //     pick(response.data, 'user').asMapOrEmpty();
  //       // user = User.fromJson(data);
  //       // notifyListeners();
  //       return response.data;
  //     }
  //   } on DioException catch (e) {
  //     setStatus(ViewStatus.Error);
  //     final response = e.response;
  //     if (response != null) {
  //       errorMessage = e.response!.data['message'];
  //       return setError(e, 'Oops Something Went Wrong, Try Again');
  //     }
  //     return setError(e, 'Oops Something Went Wrong, Try Again');
  //   } catch (e) {
  //     setStatus(ViewStatus.Error);
  //     rethrow;
  //   }
  // }


}
