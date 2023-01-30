import 'package:flutter/material.dart';
import 'package:wanted_umbrella/models/user_model.dart';
import 'package:wanted_umbrella/pages/categories/adopt_a_dog.dart';
import 'package:wanted_umbrella/pages/categories/articles_shows.dart';
import 'package:wanted_umbrella/pages/categories/chat_bot.dart';
import 'package:wanted_umbrella/pages/categories/find_a_mate.dart';
import 'package:wanted_umbrella/pages/categories/gift.dart';
import 'package:wanted_umbrella/pages/categories/gift_payment.dart';
import 'package:wanted_umbrella/pages/categories/maps.dart';
import 'package:wanted_umbrella/pages/categories/notification_page.dart';
import 'package:wanted_umbrella/pages/categories/train_pup.dart';
import 'package:wanted_umbrella/pages/chat/message_screen.dart';
import 'package:wanted_umbrella/pages/dashboard_main.dart';
import 'package:wanted_umbrella/pages/explore/explore_detail_page.dart';
import 'package:wanted_umbrella/pages/on_boarding/choose_personality.dart';
import 'package:wanted_umbrella/pages/on_boarding/forgot_password.dart';
import 'package:wanted_umbrella/pages/on_boarding/kci_certificate.dart';
import 'package:wanted_umbrella/pages/on_boarding/login.dart';
import 'package:wanted_umbrella/pages/on_boarding/register.dart';
import 'package:wanted_umbrella/pages/profile/adoption.dart';
import 'package:wanted_umbrella/pages/profile/dog_profile.dart';
import 'package:wanted_umbrella/pages/profile/help.dart';
import 'package:wanted_umbrella/pages/profile/vaccination.dart';

import 'models/userChat.dart';
import 'pages/on_boarding/dog_detail.dart';
import 'pages/on_boarding/dog_photos.dart';

class Routes {
  //onBoarding
  static const String login = '/login';
  static const String register = '/register';
  static const String forgot_password = '/forgot_password';
  static const String kci_certificate = '/kci_certificate';
  static const String dog_detail = '/dog_detail';
  static const String dog_photos = '/dog_photos';
  static const String choose_personality = '/choose_personality';

  //Dashboard
  static const String dashboard = '/dashboard';
  static const String explore_detail = '/explore_detail';
  static const String messege = '/messege';

  //categories
  static const String find_a_mate = '/find_a_mate';
  static const String notification = '/notification';
  static const String adopt_a_dog = '/adopt_a_dog';
  static const String maps = '/maps';
  static const String chat_bot = '/chat_bot';
  static const String gift = '/gift';
  static const String gift_payment = '/gift_payment';
  static const String gift_cart = '/gift_cart';
  static const String articles_shows = '/articles_shows';
  static const String train_pup = '/train_pup';

  //profle
  static const String dog_profile = '/dog_profile';
  static const String vaccination = '/vaccination';
  static const String adoption = '/adoption';
  static const String help = '/help';



  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage(), settings: const RouteSettings(name: login));
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case forgot_password:
        return MaterialPageRoute(builder: (_) => ForgotPassword());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const Dashboard(),settings: const RouteSettings(name: dashboard));
      case explore_detail:
        return MaterialPageRoute(builder: (_) => ExploreDetailsPage(userModel: settings.arguments as UserModel),settings: const RouteSettings(name: explore_detail));
      case dog_detail:
        return MaterialPageRoute(builder: (_) => DogDetail());
      case dog_photos:
        return MaterialPageRoute(builder: (_) => const DogPhotos());
      case kci_certificate:
        return MaterialPageRoute(builder: (_) => const KciCertificate());
      case choose_personality:
        return MaterialPageRoute(builder: (_) => const ChoosePersonality(), settings: const RouteSettings(name: choose_personality));
      case messege:
        List<dynamic>? args = settings.arguments as List?;
        return MaterialPageRoute(
          builder: (_) => MessageScreen(roomID : args![0], currUser: args[1],userChat: args[2] as UserChat),
        );
      case find_a_mate:
        return MaterialPageRoute(builder: (_) => const FindAMate(), settings: const RouteSettings(name: find_a_mate));
      case notification:
        return MaterialPageRoute(builder: (_) => const NotificationPage());
      case adopt_a_dog:
        return MaterialPageRoute(builder: (_) => const AdoptADog(), settings: const RouteSettings(name: adopt_a_dog));
      case maps:
        return MaterialPageRoute(builder: (_) => const Maps(),settings: const RouteSettings(name: maps));
      case chat_bot:
        return MaterialPageRoute(builder: (_) => const ChatBot(),settings: const RouteSettings(name: chat_bot));
      case gift:
        return MaterialPageRoute(builder: (_) => const Gift(),settings: const RouteSettings(name: gift));
      case gift_payment:
        return MaterialPageRoute(builder: (_) => GIftPayment(visibleUserModel: settings.arguments as UserModel),settings: const RouteSettings(name: gift_payment));
      case gift_cart:
        return MaterialPageRoute(builder: (_) => const GiftCart(),settings: const RouteSettings(name: gift_cart));
      case articles_shows:
        return MaterialPageRoute(builder: (_) => ArticlesShows(),settings: const RouteSettings(name: articles_shows));
      case train_pup:
        return MaterialPageRoute(builder: (_) => TrainPup(),settings: const RouteSettings(name: train_pup));
      case dog_profile:
        return MaterialPageRoute(builder: (_) => DogProfile(),settings: const RouteSettings(name: dog_profile));
      case vaccination:
        return MaterialPageRoute(builder: (_) => Vaccination(),settings: const RouteSettings(name: vaccination));
      case adoption:
        return MaterialPageRoute(builder: (_) => Adoption(),settings: const RouteSettings(name: adoption));
      case help:
        return MaterialPageRoute(builder: (_) => HelpPage(),settings: const RouteSettings(name: help));
    }
    return MaterialPageRoute(builder: (_) => Container());
  }
}

Route _createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}