import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gp/auth/model/skill_model.dart';
import 'package:gp/component/long_button.dart';
import 'package:gp/dashboard/profile/bloc/profile_cubit.dart';
import 'package:gp/dashboard/profile/bloc/profile_state.dart';
import 'package:gp/dashboard/skill/model/skill.dart';

import '../auth/bloc/auth_cubit.dart';
import '../firestore/firestore_services.dart';
import 'constants.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, text;
  // final Image img;

  const CustomDialogBox({super.key, required this.title, required this.text});


  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  //
  // final TextEditingController _controller = TextEditingController();
  // final TextEditingController _controllerSkill = TextEditingController();
  List<SkillModel> skillList = [];


  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    FireStoreService fireStoreService = FireStoreService();
    loadSkillNames(fireStoreService);
  }

  Future<void> loadSkillNames(FireStoreService fireStoreService) async {
    skillList.clear();
    skillList = await fireStoreService.getSkillNameList();
    print('Unilist: $skillList');
  }



  @override
  Widget build(BuildContext context) {

    return BlocProvider(create: (context) => ProfileCubit(studentID: FirebaseAuth.instance.currentUser!.uid),
    child: BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.padding),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child:  Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(
                    left: Constants.padding,
                    top: Constants.avatarRadius + Constants.padding,
                    right: Constants.padding,
                    bottom: Constants.padding),
                margin: const EdgeInsets.only(top: Constants.avatarRadius),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Constants.padding),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // Text(
                    //   widget.descriptions,
                    //   style: TextStyle(fontSize: 14),
                    //   textAlign: TextAlign.center,
                    // ),


                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        context
                            .read<ProfileCubit>()
                            .updateSinglePropertyOnState('dreamJOb', value);
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Write you dream job Title',
                        labelText: 'Dream Job',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TypeAheadField(
                      textFieldConfiguration: const TextFieldConfiguration(
                        // enabled: _controllerSkill.text.isEmpty,
                        // controller: _controllerSkill,
                        decoration: InputDecoration(
                          labelText: 'Required SKill For Dream Job',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      suggestionsCallback: (pattern) {
                        return skillList.where((skill) => skill
                            .name
                            .toLowerCase()
                            .contains(pattern.toLowerCase()));
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion.name),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        context.read<ProfileCubit>().updateSinglePropertyOnState(
                            'requiredSkill', suggestion);
                      },
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: LongButton(
                          isDisabled: state.dreamJOb.isEmpty || state.requiredSkill.name.isEmpty,//_controller.text.isEmpty,
                          onPressed: () {
                            // context.read<GPAuthCubit>().login(context, role);
                            FireStoreService().storeDreamJob(state.dreamJOb);
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            widget.text,
                            style: TextStyle(fontSize: 18),
                          )),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: Constants.padding,
                right: Constants.padding,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: Constants.avatarRadius,
                  child: ClipRRect(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                      child: Image.asset("assets/gprofile.png")),
                ),
              ),
            ],
          ),
        );
      },
    ),);

  }

}
