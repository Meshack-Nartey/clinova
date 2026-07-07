import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/auth/providers.dart';
import '../../core/database/tables.dart';
import '../../core/settings/settings_providers.dart';
import '../../features/admin/staff_screen.dart';
import '../../features/auth/login_screen.dart';
import '../../features/consultation/consultation_screen.dart';
import '../../features/dashboard/dashboard_screen.dart';
import '../../features/intake/intake_screen.dart';
import '../../features/lab/lab_screen.dart';
import '../../features/pharmacy/pharmacy_screen.dart';
import '../../features/search/search_screen.dart';
import '../../features/setup/setup_screen.dart';

// Route names
const routeLogin = '/login';
const routeDashboard = '/dashboard';
const routeIntake = '/intake';
const routeIntakeEdit = '/intake/:patientId';
const routeConsultation = '/consultation/:patientId';
const routePharmacy = '/pharmacy/:patientId';
const routeLab = '/lab/:patientId';
const routeSearch = '/search';
const routeStaff = '/staff';
const routeSetup = '/setup';

final routerProvider = Provider<GoRouter>((ref) {
  final sessionNotifier = ref.watch(sessionProvider.notifier);
  final clinicNameNotifier = ref.watch(clinicNameProvider.notifier);

  return GoRouter(
    initialLocation: routeLogin,
    redirect: (context, state) {
      final clinicName = ref.read(clinicNameProvider);
      final session = ref.read(sessionProvider);
      final loc = state.matchedLocation;

      // Wait for providers to initialise
      if (clinicName is AsyncLoading || session is AsyncLoading) return null;

      // First-run: clinic not configured — only /setup is allowed
      if (clinicName.valueOrNull == null) {
        return loc == routeSetup ? null : routeSetup;
      }

      // Clinic configured but still on setup → go to login
      if (loc == routeSetup) return routeLogin;

      // Not authenticated → go to login
      final authSession = session.valueOrNull;
      if (authSession == null) {
        return loc == routeLogin ? null : routeLogin;
      }

      // Authenticated and sitting on login → go home
      if (loc == routeLogin) return _homeForRole(authSession.role);

      return null;
    },
    refreshListenable: _CompositeListenable(ref, [sessionNotifier, clinicNameNotifier]),
    routes: [
      GoRoute(path: routeSetup, builder: (ctx, _) => const SetupScreen()),
      GoRoute(path: routeLogin, builder: (ctx, _) => const LoginScreen()),
      GoRoute(path: routeDashboard, builder: (ctx, _) => const DashboardScreen()),
      GoRoute(path: routeSearch, builder: (ctx, _) => const SearchScreen()),
      GoRoute(path: routeStaff, builder: (ctx, _) => const StaffScreen()),
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
      UserRole.admin || UserRole.doctor || UserRole.nurse => routeDashboard,
      UserRole.pharmacist => routeSearch,
      UserRole.lab => routeSearch,
    };

/// Makes GoRouter react to changes in any of the provided Riverpod providers.
class _CompositeListenable extends ChangeNotifier {
  _CompositeListenable(Ref ref, List<StateNotifier> notifiers) {
    ref.listen(sessionProvider, (prev, next) => notifyListeners());
    ref.listen(clinicNameProvider, (prev, next) => notifyListeners());
  }
}
