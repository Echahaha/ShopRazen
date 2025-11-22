import 'package:get/get.dart';

import '../modules/account/bindings/account_binding.dart';
import '../modules/account/views/account_view.dart';
import '../modules/autentifikasi/login/bindings/login_binding.dart';
import '../modules/autentifikasi/login/views/login_view.dart';
import '../modules/autentifikasi/lupa_password/bindings/lupa_password_binding.dart';
import '../modules/autentifikasi/lupa_password/views/lupa_password_view.dart';
import '../modules/autentifikasi/onboarding/bindings/onboarding_binding.dart';
import '../modules/autentifikasi/onboarding/views/onboarding_view.dart';
import '../modules/autentifikasi/otp_verification/bindings/otp_verification_binding.dart';
import '../modules/autentifikasi/otp_verification/views/otp_verification_view.dart';
import '../modules/autentifikasi/register/bindings/register_binding.dart';
import '../modules/autentifikasi/register/views/register_view.dart';
import '../modules/autentifikasi/splash/bindings/splash_binding.dart';
import '../modules/autentifikasi/splash/views/splash_view.dart';
import '../modules/consultation/bindings/consultation_binding.dart';
import '../modules/consultation/views/consultation_view.dart';
import '../modules/contract/bindings/contract_binding.dart';
import '../modules/contract/views/contract_view.dart';
import '../modules/dashboard_admin/adminhome/bindings/adminhome_binding.dart';
import '../modules/dashboard_admin/adminhome/views/adminhome_view.dart';
import '../modules/dashboard_customer/home/bindings/home_binding.dart';
import '../modules/dashboard_customer/home/views/home_view.dart';
import '../modules/dashboard_customer/order_tracking/bindings/order_tracking_binding.dart';
import '../modules/dashboard_customer/order_tracking/views/order_tracking_view.dart';
import '../modules/dashboard_customer/payment/bindings/payment_binding.dart';
import '../modules/dashboard_customer/payment/views/payment_view.dart';
import '../modules/dashboard_customer/wishlist/bindings/wishlist_binding.dart';
import '../modules/dashboard_customer/wishlist/views/wishlist_view.dart';
import '../modules/main_navigation/bindings/main_navigation_binding.dart';
import '../modules/main_navigation/views/main_navigation_view.dart';
import '../modules/orders/bindings/orders_binding.dart';
import '../modules/orders/views/orders_view.dart';
import '../modules/orders/views/order_detail_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.OTP_VERIFICATION,
      page: () => const OtpVerificationView(),
      binding: OtpVerificationBinding(),
    ),
    GetPage(
      name: _Paths.LUPA_PASSWORD,
      page: () => const LupaPasswordView(),
      binding: LupaPasswordBinding(),
    ),
    GetPage(
      name: _Paths.WISHLIST,
      page: () => WishlistView(),
      binding: WishlistBinding(),
    ),
    GetPage(
      name: _Paths.ADMINHOME,
      page: () => AdminHomeView(),
      binding: AdminhomeBinding(),
    ),
    GetPage(
      name: _Paths.CONSULTATION,
      page: () => ConsultationView(),
      binding: ConsultationBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT,
      page: () => PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.CONTRACT,
      page: () => const ContractView(),
      binding: ContractBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_TRACKING,
      page: () => OrderTrackingView(),
      binding: OrderTrackingBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_NAVIGATION,
      page: () => MainNavigationView(),
      binding: MainNavigationBinding(),
    ),
    GetPage(
      name: '/notifications',
      page: () => NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: '/order-detail',
      page: () => OrderDetailView(),
      // OrdersBinding is already registered in MainNavigationBinding; no extra binding needed
    ),
    GetPage(
      name: _Paths.ORDERS,
      page: () => OrdersView(),
      binding: OrdersBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT,
      page: () => AccountView(),
      binding: AccountBinding(),
    ),
  ];
}
