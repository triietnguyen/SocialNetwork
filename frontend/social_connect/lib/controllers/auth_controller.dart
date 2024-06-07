import 'package:get/get.dart';
import '../services/api_service.dart';
import '../views/home_view.dart';

class AuthController extends GetxController {
  final ApiService _apiService = ApiService();

  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  var token = ''.obs;
  var username = ''.obs;

  void login(String username, String password) async {
    isLoading.value = true;
    try {
      final response = await _apiService.login(username, password);
      token.value = response.data['token'];
      this.username.value = username;
      isLoggedIn.value = true;
      Get.snackbar('Success', 'Logged in successfully');
      Get.offAll(() => HomeView()); // Điều hướng đến HomeView
    } catch (e) {
      Get.snackbar('Error', 'Login failed');
    } finally {
      isLoading.value = false;
    }
  }

  void register(String username, String password) async {
    isLoading.value = true;
    try {
      await _apiService.register(username, password);
      Get.snackbar('Success', 'Registered successfully');
    } catch (e) {
      Get.snackbar('Error', 'Registration failed');
    } finally {
      isLoading.value = false;
    }
  }

  void checkConnection() async {
    try {
      await _apiService.checkConnection();
      Get.snackbar('Success', 'Connected to backend');
    } catch (e) {
      Get.snackbar('Error', 'Connection failed');
    }
  }
}
