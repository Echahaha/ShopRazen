import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoprazen/app/routes/app_pages.dart';

class LoginController extends GetxController {
  // Text Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  // Observable variables
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var isPasswordHidden = true.obs;
  
  @override
  void onInit() {
    super.onInit();
  }
  
  // Password visibility toggle
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }
  
  // Login function dengan validasi password
  Future<void> login() async {
    isLoading.value = true;
    errorMessage.value = '';
    
    try {
      // Validasi input
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        errorMessage.value = 'Email and password must be filled';
        isLoading.value = false;
        return;
      }
      
      // Validasi format email
      if (!GetUtils.isEmail(emailController.text)) {
        errorMessage.value = 'Please enter a valid email address';
        isLoading.value = false;
        return;
      }
      
      // Simulasi loading
      await Future.delayed(Duration(milliseconds: 1000));
      
      // Autentikasi user
      Map<String, dynamic>? userAuth = _authenticateUser(
        emailController.text, 
        passwordController.text
      );
      
      if (userAuth == null) {
        errorMessage.value = 'Invalid email or password';
        isLoading.value = false;
        return;
      }
      
      // Simpan user info jika perlu (uncomment jika menggunakan storage)
      // await storage.write('user_role', userAuth['role']);
      // await storage.write('user_name', userAuth['name']);
      // await storage.write('user_email', emailController.text);
      
      // Redirect berdasarkan role
      if (userAuth['role'] == 'admin') {
        Get.offAllNamed(Routes.ADMINHOME);
      } else {
        // Use MAIN_NAVIGATION so the bottom navigation (Scaffold) is the root
        Get.offAllNamed(Routes.MAIN_NAVIGATION);
      }
      
    } catch (e) {
      errorMessage.value = 'An error occurred during login';
      print('Login error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Fungsi autentikasi user (dummy data untuk testing)
  Map<String, dynamic>? _authenticateUser(String email, String password) {
    // Dummy data untuk testing
    // Nanti diganti dengan API call
    
    Map<String, Map<String, dynamic>> dummyUsers = {
      // Admin users
      'admin@razen.com': {
        'password': 'admin123',
        'role': 'admin',
        'name': 'Super Admin',
        'division': 'All Divisions',
      },
      'admin.digital@razen.com': {
        'password': 'admin123',
        'role': 'admin',
        'name': 'Admin Digital Marketing',
        'division': 'Digital Marketing',
      },
      'admin.webdev@razen.com': {
        'password': 'admin123',
        'role': 'admin',
        'name': 'Admin Web Development',
        'division': 'Web Development',
      },
      
      // Regular users
      'user@gmail.com': {
        'password': 'user123',
        'role': 'user',
        'name': 'Regular User',
      },
      'test@gmail.com': {
        'password': 'test123',
        'role': 'user',
        'name': 'Test User',
      },
    };
    
    // Cek apakah email ada (case insensitive)
    if (!dummyUsers.containsKey(email.toLowerCase())) {
      return null;
    }
    
    // Cek password
    if (dummyUsers[email.toLowerCase()]!['password'] != password) {
      return null;
    }
    
    return dummyUsers[email.toLowerCase()];
  }
  
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}