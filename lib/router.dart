import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_deliver/features/authentication/auth_state.dart';
import 'package:quick_deliver/features/authentication/register.dart';
import 'package:quick_deliver/features/authentication/signin.dart';
import 'package:quick_deliver/features/onboarding.dart';
import 'package:quick_deliver/features/order/make_order.dart';
import 'package:quick_deliver/features/order/order_details.dart';
import 'package:quick_deliver/features/order/orders.dart';

final authNotifier = AuthNotifier();
final GoRouter router = GoRouter(
initialLocation: '/',
refreshListenable: authNotifier,
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Onboarding();
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/signin',
          name: '/signin',
          builder: (BuildContext context, GoRouterState state) {
            return const SignIn();
          },
        ),
         GoRoute(
          path: '/signup',
          name: '/signup',
          builder: (BuildContext context, GoRouterState state) {
            return const SignUp();
          },
        ),

        GoRoute(
          path: '/order',
          name: '/order',
          builder: (BuildContext context, GoRouterState state) {
            return const Order();
          },
        ),
        GoRoute(
          path: '/myorders',
          builder: (BuildContext context, GoRouterState state) {
            return const MyOrders();
          },
        ),
        GoRoute(
          path: '/orderdetails/:orderId',
          name:'/orderdetails/:orderId' ,
          builder: (context, state) {
          final id = state.pathParameters['id']!;
        return OrderDetails(orderId: id,);
      },
    ),
      ],
    ),
    
  ],
  redirect: (context, state) {
  final isLoggedIn = authNotifier.isLoggedIn;
  final isOnLoginPage = state.matchedLocation == '/signin';

  if (!isLoggedIn && !isOnLoginPage) {
    return authNotifier.currentUser==null? '/':'/signin';
  }
  

  if (isLoggedIn) {
    return '/order';
  }
   return null;
}
);