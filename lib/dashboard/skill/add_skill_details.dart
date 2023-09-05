import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/dashboard/skill/bloc/add_skill_cubit.dart';
import '../../component/long_button.dart';
import 'bloc/add_skill_details_state.dart';

class AddSkillDetails extends StatelessWidget {
  final String? skillID;

  final String? skillName;

  const AddSkillDetails(
      {super.key, required this.skillID, required this.skillName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddSkillDetailsCubit(AddSkillDetailsState.initial()),
      child: BlocBuilder<AddSkillDetailsCubit, AddSkillDetailsState>(
          builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(skillName!),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(children: [
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  onChanged: (value) {
                    context
                        .read<AddSkillDetailsCubit>()
                        .updateSinglePropertyOnState('courseName', value);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter your Course name',
                    labelText: 'Course Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),

                TextFormField(
                  onChanged: (value) {
                    context
                        .read<AddSkillDetailsCubit>()
                        .updateSinglePropertyOnState('courseLeaderName', value);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter your Course Leader name',
                    labelText: 'Course Leader name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  onChanged: (value) {
                    context
                        .read<AddSkillDetailsCubit>()
                        .updateSinglePropertyOnState('courseLeaderMail', value);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter your Course Leader mail',
                    labelText: 'leader mail',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  onChanged: (value) {
                    context
                        .read<AddSkillDetailsCubit>()
                        .updateSinglePropertyOnState('courseLecturerMail', value);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter your Course lecturer mail',
                    labelText: 'Course lecturer mail',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  onChanged: (value) {
                    context
                        .read<AddSkillDetailsCubit>()
                        .updateSinglePropertyOnState('courseWork', value);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter your Course work details',
                    labelText: 'Course work',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  onChanged: (value) {
                    context
                        .read<AddSkillDetailsCubit>()
                        .updateSinglePropertyOnState('project', value);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter your Project details',
                    labelText: 'Project links',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  onChanged: (value) {
                    context.read<AddSkillDetailsCubit>().updateSinglePropertyOnState(
                        'additionalMessage', value);
                  },
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'Additional Message to Course Leader',
                    labelText: 'Message',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                LongButton(
                  isLoading: state.isLoading,
                  isDisabled: state.courseName.isEmpty ||
                      state.courseLecturerMail.isEmpty,
                  onPressed: () {
                    print('${state.courseName}- ${state.courseLecturerMail}- ${state.courseLeaderMail} -${state.additionalMessage}- ${state.courseWork} -${state.project}');
                    context
                        .read<AddSkillDetailsCubit>()
                        .sendValidationRequest(context);
                  },
                  child: const Text('Send Verification request'),
                ),
              ]),
            ),
          ),
        );
      }),
    );
  }
}
