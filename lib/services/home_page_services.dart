import 'package:dio/dio.dart';

import '../locator.dart';
import '../utils/local_store.dart';
import 'api_services.dart';

class HomePageServices {
  final Dio _apiClient;

  static final ApiService _apiServices = locator<ApiService>();

  HomePageServices() : _apiClient = _apiServices.client;



  Future<Response> getMeDetails() {
    return _apiClient.get('/me');
  }

  Future download(orderId) async {
    final String authToken = await LocalStoreHelper.getUserToken();

    if (authToken.isNotEmpty) {
      _apiClient.options.headers['Authorization'] = 'Bearer $authToken';

      return _apiClient.get('/orders/$orderId/receipt',
          options: Options(responseType: ResponseType.bytes));
    }
  }

  // Function to handle multipart requests with custom headers
  // Future<Response> postMultipartForm(FormData formData) async {
  //
  //   try {
  //     Response response = await _apiClient.post('/stories', data: formData,
  //       options: Options(
  //         headers: {
  //           "Content-Type": "multipart/form-data",
  //         },
  //       ),
  //     );
  //     return response;
  //   } catch (e) {
  //     // Handle error
  //     rethrow;
  //   }
  // }

  Future<Response> generateUploadUrl(apiRequestPayload) {
    return _apiClient.post('/generate-upload-url', data: apiRequestPayload);
  }

  Future<Response> postMultipartForm(formData) async {
    return _apiClient.post('/stories', data: formData);
  }

}
