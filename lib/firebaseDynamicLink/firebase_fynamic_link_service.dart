import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:gp/dashboard/skill/model/validation_request.dart';

class FirebaseDynamicLinkService {

  static Future<String> generateValidationRequest(ValidationRequest validationRequest)async{
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://graduateskillset.page.link',
      link: Uri.parse('https://graduateskillset.page.link/?'
          'studentId=${validationRequest.studentID}&'
          'skillId=${validationRequest.skillID}'),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.gp',
        minimumVersion: 001,
      ),
    );

    print('parameters: $parameters');
    var url = await dynamicLinks.buildLink(parameters);
    print('url: $url');
    return url.toString();

  }



  static Future<void> initDynamicLinks(BuildContext context) async {
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;


    dynamicLinks.onLink.listen((dynamicLinkData) {
      // Navigator.pushNamed(context, dynamicLinkData.link.path);
      print('onLink ${dynamicLinkData.link.toString()}}');
      final Uri deepLink = dynamicLinkData.link;
      var studentId = deepLink.queryParameters['studentId'];
      var skillId = deepLink.queryParameters['skillId'];

      print('studentId: $studentId');
      print('skillID: $skillId');


      context.go('/skillValidation/$studentId/$skillId');
      // context.go('/skillValidation');
      //Navigator.of(context).pushNamed('/skillValidation');
      // context.go('/skillValidation');

    }).onError((error) {
      print('onLink error');
      print(error.message);
    });

  }


}