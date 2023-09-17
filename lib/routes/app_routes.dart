import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gp/dashboard/validation/skill_validation.dart';
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
           // return const Dashboard();
          return const LoginPage();
          //return const SkillValidation(skillID: "sX1I8wa2LxGorg8TRE8S", studentID: "rYgOCh9A3OfKjwAX2qsO6aTu5wG2");
        },
        routes: <RouteBase>[
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
