import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/dashboard/validation/bloc/validation_state.dart';

import '../../component/animated_list_tile.dart';
import '../../component/list_tile_border_radius.dart';
import '../skill/model/skill.dart';
import 'bloc/validation_cubit.dart';

class SkillValidation extends StatefulWidget {
  final String? skillID;
  final String? studentID;

  const SkillValidation(
      {super.key, required this.skillID, required this.studentID});

  @override
  State<SkillValidation> createState() => _SkillValidationState();
}

class _SkillValidationState extends State<SkillValidation> {

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => ValidationCubit(skillID: widget.skillID, studentID: widget.studentID),
    child: BlocBuilder<ValidationCubit, ValidationState>(
      builder: (context, state){
        return Scaffold(
          appBar: AppBar(
            title: const Text('Skill Validation Request'),
          ),
          body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
// padding: const EdgeInsets.all(10.0),
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    AnimatedListTile(
                      borderRadius: ListTileBorderRadius.onlyTop,
                      title: const Text('Student Name'),
                      trailing: const Text(
                        'ISMAIL',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    AnimatedListTile(
                      borderRadius: ListTileBorderRadius.none,
                      title: const Text('Department'),
                      trailing: const Text(
                        'ISMAIL',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    AnimatedListTile(
                      borderRadius: ListTileBorderRadius.none,
                      title: const Text('Course'),
                      trailing: const Text(
                        'ISMAIL',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    AnimatedListTile(
                      borderRadius: ListTileBorderRadius.none,
                      title: const Text('Student ID'),
                      trailing: const Text(
                        'ISMAIL',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    AnimatedListTile(
                      borderRadius: ListTileBorderRadius.none,
                      title: const Text('Course Work'),
                      trailing: const Text(
                        'ISMAIL',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    AnimatedListTile(
                      borderRadius: ListTileBorderRadius.onlyBottom,
                      title: const Text('Project Link'),
                      trailing: const Text(
                        'ISMAIL',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )),
        );
      }
    ),
    );

  }
}




