import 'package:flutter/material.dart';
import '../../presentation/screens/splash_screen.dart';
import '../../presentation/screens/login_screen.dart';
import '../../presentation/screens/register_screen.dart';

import '../../presentation/screens/add_trade_screen.dart';
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/trade_detail_screen.dart';
import '../../presentation/screens/edit_profile_screen.dart';
import '../../presentation/screens/change_password_screen.dart';
import '../../presentation/screens/notifications_screen.dart';
import '../../domain/entities/trade_entity.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String addTrade = '/add-trade';
  static const String tradeDetail = '/trade-detail';
  static const String editProfile = '/edit-profile';
  static const String changePassword = '/change-password';
  static const String notifications = '/notifications';

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case addTrade:
        return MaterialPageRoute(builder: (_) => const AddTradeScreen());
      case tradeDetail:
        final trade = settings.arguments as TradeEntity;
        return MaterialPageRoute(
          builder: (_) => TradeDetailScreen(trade: trade),
        );
      case editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case changePassword:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());
      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
