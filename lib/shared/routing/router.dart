import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/auth/providers.dart';
import '../../core/database/tables.dart';
import '../../features/auth/login_screen.dart';
import '../../features/consultation/consultation_screen.dart';
import '../../features/dashboard/dashboard_screen.dart';
import '../../features/intake/intake_screen.dart';
import '../../features/lab/lab_screen.dart';
import '../../features/pharmacy/pharmacy_screen.dart';
import '../../features/search/search_screen.dart';

// Route names
const routeLogin = '/login';
const routeDashboard = '/dashboard';
const routeIntake = '/intake';
const routeIntakeEdit = '/intake/:patientId';
const routeConsultation = '/consultation/:patientId';
const routePharmacy = '/pharmacy/:patientId';
const routeLab = '/lab/:patientId';
const routeSearch = '/search';

final routerProvider = Provider<GoRouter>((ref) {
  final sessionNotifier = ref.watch(sessionProvider.notifier);

  return GoRouter(
    initialLocation: routeLogin,
    redirect: (context, state) {
      final session = ref.read(sessionProvider);
      final isLoggingIn = state.matchedLocation == routeLogin;

      if (session is AsyncLoading) return null;

      final authSession = session.valueOrNull;
      if (authSession == null) {
        return isLoggingIn ? null : routeLogin;
      }
      if (isLoggingIn) {
        return _homeForRole(authSession.role);
      }
      return null;
    },
    refreshListenable: _SessionListenable(ref, sessionNotifier),
    routes: [
      GoRoute(path: routeLogin, builder: (ctx, _) => const LoginScreen()),
      GoRoute(path: routeDashboard, builder: (ctx, _) => const DashboardScreen()),
      GoRoute(path: routeSearch, builder: (ctx, _) => const SearchScreen()),
      GoRoute(
        path: routeIntake,
        builder: (ctx, _) => const IntakeScreen(patientId: null),
      ),
      GoRoute(
        path: routeIntakeEdit,
        builder: (_, state) => IntakeScreen(patientId: state.pathParameters['patientId']),
      ),
      GoRoute(
        path: routeConsultation,
        builder: (_, state) =>
            ConsultationScreen(patientId: state.pathParameters['patientId']!),
      ),
      GoRoute(
        path: routePharmacy,
        builder: (_, state) =>
            PharmacyScreen(patientId: state.pathParameters['patientId']!),
      ),
      GoRoute(
        path: routeLab,
        builder: (_, state) => LabScreen(patientId: state.pathParameters['patientId']!),
      ),
    ],
  );
});

String _homeForRole(UserRole role) => switch (role) {
      UserRole.admin || UserRole.doctor => routeDashboard,
      UserRole.nurse => routeIntake,
      UserRole.pharmacist => routeSearch,
      UserRole.lab => routeSearch,
    };

/// Makes GoRouter react to Riverpod session changes.
class _SessionListenable extends ChangeNotifier {
  _SessionListenable(Ref ref, StateNotifier notifier) {
    ref.listen(sessionProvider, (prev, next) => notifyListeners());
  }
}
