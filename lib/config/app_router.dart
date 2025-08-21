import 'package:go_router/go_router.dart';
import 'package:techfix_pro/modules/auth/screens/cosmic_login_screen.dart';
import 'package:techfix_pro/modules/auth/screens/register_screen.dart';
import 'package:techfix_pro/modules/auth/screens/forgot_password_screen.dart';
import 'package:techfix_pro/modules/marketplace/screens/3d_marketplace.dart';
import 'package:techfix_pro/modules/marketplace/screens/marketplace_screen.dart';
import 'package:techfix_pro/modules/marketplace/screens/product_detail_screen.dart';
import 'package:techfix_pro/modules/marketplace/screens/cart_screen.dart';
import 'package:techfix_pro/modules/repair/screens/repair_service_screen.dart';
import 'package:techfix_pro/modules/repair/screens/booking_screen.dart';
import 'package:techfix_pro/modules/repair/screens/tracking_screen.dart';
import 'package:techfix_pro/modules/repair/screens/remote_support_screen.dart';
import 'package:techfix_pro/modules/support/screens/support_chat_screen.dart';
import 'package:techfix_pro/modules/support/screens/faq_screen.dart';
import 'package:techfix_pro/modules/support/screens/contact_screen.dart';
import 'package:techfix_pro/modules/payment/screens/payment_screen.dart';
import 'package:techfix_pro/modules/payment/screens/payment_success_screen.dart';
import 'package:techfix_pro/modules/payment/screens/invoice_screen.dart';
import 'package:techfix_pro/modules/community/screens/reviews_screen.dart';
import 'package:techfix_pro/modules/community/screens/ratings_screen.dart';
import 'package:techfix_pro/modules/community/screens/community_screen.dart';
import 'package:techfix_pro/modules/tracking/screens/live_tracking_screen.dart';
import 'package:techfix_pro/screens/main_screen.dart';
import 'package:techfix_pro/screens/splash_screen.dart';
import 'package:techfix_pro/screens/profile_screen.dart';
import 'package:techfix_pro/screens/settings_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      // شاشة البداية
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // المصادقة
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const CosmicLoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgotPassword',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      // الشاشة الرئيسية
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const MainScreen(),
      ),

      // متجر قطع الغيار
      GoRoute(
        path: '/marketplace',
        name: 'marketplace',
        builder: (context, state) => const MarketplaceScreen(),
      ),
      GoRoute(
        path: '/marketplace/3d',
        name: 'marketplace3d',
        builder: (context, state) => const ThreeDMarketplace(),
      ),
      GoRoute(
        path: '/product/:id',
        name: 'productDetail',
        builder: (context, state) {
          final productId = state.pathParameters['id']!;
          return ProductDetailScreen(productId: productId);
        },
      ),
      GoRoute(
        path: '/cart',
        name: 'cart',
        builder: (context, state) => const CartScreen(),
      ),

      // خدمات الصيانة
      GoRoute(
        path: '/repair',
        name: 'repair',
        builder: (context, state) => const RepairServiceScreen(),
      ),
      GoRoute(
        path: '/booking',
        name: 'booking',
        builder: (context, state) => const BookingScreen(),
      ),
      GoRoute(
        path: '/tracking/:orderId',
        name: 'tracking',
        builder: (context, state) {
          final orderId = state.pathParameters['orderId']!;
          return TrackingScreen(orderId: orderId);
        },
      ),
      GoRoute(
        path: '/remote-support',
        name: 'remoteSupport',builder: (context, state) => const RemoteSupportScreen(),
      ),

      // الدعم الفني
      GoRoute(
        path: '/support',
        name: 'support',
        builder: (context, state) => const SupportChatScreen(),
      ),
      GoRoute(
        path: '/faq',
        name: 'faq',
        builder: (context, state) => const FaqScreen(),
      ),
      GoRoute(
        path: '/contact',
        name: 'contact',
        builder: (context, state) => const ContactScreen(),
      ),

      // التتبع الحي
      GoRoute(
        path: '/live-tracking/:technicianId',
        name: 'liveTracking',
        builder: (context, state) {
          final technicianId = state.pathParameters['technicianId']!;
          return LiveTrackingScreen(technicianId: technicianId);
        },
      ),

      // الدفع
      GoRoute(
        path: '/payment',
        name: 'payment',
        builder: (context, state) => const PaymentScreen(),
      ),
      GoRoute(
        path: '/payment/success',
        name: 'paymentSuccess',
        builder: (context, state) => const PaymentSuccessScreen(),
      ),
      GoRoute(
        path: '/invoice/:invoiceId',
        name: 'invoice',
        builder: (context, state) {
          final invoiceId = state.pathParameters['invoiceId']!;
          return InvoiceScreen(invoiceId: invoiceId);
        },
      ),

      // المجتمع والتقييمات
      GoRoute(
        path: '/reviews',
        name: 'reviews',
        builder: (context, state) => const ReviewsScreen(),
      ),
      GoRoute(
        path: '/ratings',
        name: 'ratings',
        builder: (context, state) => const RatingsScreen(),
      ),
      GoRoute(
        path: '/community',
        name: 'community',
        builder: (context, state) => const CommunityScreen(),
      ),

      // الملف الشخصي والإعدادات
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),

      // الصفحة غير موجودة
      GoRoute(
        path: '/404',
        name: 'notFound',
        builder: (context, state) => const Scaffold(
          body: Center(
            child: Text('الصفحة غير موجودة'),
          ),
        ),
      ),
    ],

    // إعادة التوجيه
    redirect: (context, state) {
      // يمكنك إضافة منطق إعادة التوجيه هنا
      // مثلاً التحقق من حالة المصادقة
      return null;
    },

    // معالج الأخطاء
    errorBuilder: (context, state) => const Scaffold(
      body: Center(
        child: Text('حدث خطأ في التوجيه'),
      ),
    ),
  );

  // دوال مساعدة للتنقل
  static void goToLogin(BuildContext context) {
    context.goNamed('login');
  }

  static void goToHome(BuildContext context) {
    context.goNamed('home');
  }

  static void goToMarketplace(BuildContext context) {
    context.goNamed('marketplace');
  }

  static void goToProductDetail(BuildContext context, String productId) {
    context.goNamed('productDetail', pathParameters: {'id': productId});
  }

  static void goToRepairServices(BuildContext context) {
    context.goNamed('repair');
  }

  static void goToTracking(BuildContext context, String orderId) {
    context.goNamed('tracking', pathParameters: {'orderId': orderId});
  }

  static void goToPayment(BuildContext context) {
    context.goNamed('payment');
  }

  static void goToProfile(BuildContext context) {
    context.goNamed('profile');
  }

  // دالة للرجوع للخلف مع إمكانية التخصيص
  static void goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      goToHome(context);
    }
  }
}

// ملحق لتحسين تجربة التنقل
extension GoRouterExtension on GoRouter {
  void safePush(BuildContext context, String path) {
    if (location != path) {
      push(path);
    }
  }

  void safeReplace(BuildContext context, String path) {
    if (location != path) {
      replace(path);
    }
  }
}