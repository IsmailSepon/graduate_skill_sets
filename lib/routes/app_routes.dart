import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gp/dashboard/resume/pdf_viewer_page.dart';
import 'package:gp/dashboard/validation/skill_validation.dart';
import 'package:gp/teacher_dashboard/teacher_dashboard.dart';
import '../auth/login.dart';
import '../auth/registration.dart';
import '../auth/teacher/teacher_registration.dart';
import '../dashboard/dashboard.dart';
import '../dashboard/skill/add_skill.dart';
import '../dashboard/skill/add_skill_details.dart';
import '../firebaseDynamicLink/firebase_fynamic_link_service.dart';

class AppRoutes {
  /// The route configuration.
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          // Initialize dynamic links service within this route's builder
          FirebaseDynamicLinkService.initDynamicLinks(context);
            return const Dashboard();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'teacherDashboard',
            builder: (BuildContext context, GoRouterState state) {
              return const TeacherDashBoard();
            },
          ),
          GoRoute(
            path: 'login',
            builder: (BuildContext context, GoRouterState state) {
              return const LoginPage();
            },
          ),
          GoRoute(
            path: 'registration',
            builder: (BuildContext context, GoRouterState state) {
              return const Registration();
            },
          ),
          GoRoute(
            path: 'teacherRegistration',
            builder: (BuildContext context, GoRouterState state) {
              return const TeacherRegistration();
            },
          ),
          GoRoute(
            path: 'addSkill',
            builder: (BuildContext context, GoRouterState state) {
              return const AddSkill();
            },
          ),
          GoRoute(
            path: 'skillValidation/:studentId/:skillId',
            builder: (BuildContext context, GoRouterState state) {
              final studentId = state.pathParameters['studentId']!;
              final skillId = state.pathParameters['skillId']!;
              return SkillValidation(
                skillID: skillId,
                studentID: studentId,
              );
            },
          ),
          GoRoute(
            path: 'details/:name/:id',
            builder: (BuildContext context, GoRouterState state) {
              final id = state.pathParameters['id']!;
              final name = state.pathParameters['name']!;
              return AddSkillDetails(
                skillID: id,
                skillName: name,
              );
            },
          ),
          GoRoute(
            path: 'resume/:path',
            builder: (BuildContext context, GoRouterState state) {
              return PDFViewerPage(
                pdfPath: state.pathParameters['path']!,
              );
            },
          ),
          // GoRoute(
          //   path:'addSkillDetails/:id/:name',
          //   name: 'addSkillDetails',
          //   builder: (context, state) => addSkillDetails(
          //     skillID: state.pathParameters['id'],
          //     skillName: state.pathParameters['name'],
          //   ),
          // ),
          // GoRoute(
          //   path: 'dashboard',
          //   builder: (BuildContext context, GoRouterState state) {
          //     return const Registration();
          //   },
          // ),
        ],
      ),
    ],
  );
}
