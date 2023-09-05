import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../dashboard/skill/model/skill.dart';
import 'app_theme.dart';

class SkillListTile extends StatelessWidget {
  final Skill skill;

  const SkillListTile({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          height: 140,
          child: Card(
            elevation: 3,
            child: Row(
              children: [
                Image(
                  image: Image.asset(
                    'assets/skill_icon.jpg',
                  ).image,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        skill.name,
                        style: TextStyle(
                          fontSize: AppThemes.h2FontSize,
                          fontWeight: FontWeight.bold,
                          color: AppThemes.mainColorGreen,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(skill.courseName),
                      const SizedBox(height: 5,),
                      Text(
                          'Status: ${skill.verifyStatus==true?'Verified by ${skill.courseLeaderName}': 'Verification Pending'}',
                      style: TextStyle(color: skill.verifyStatus ? Colors.green : Colors.red),),

                      const SizedBox(height: 5,),

                      if (skill.score != 0)
                        RatingBarIndicator(
                            rating: 2.5,
                            itemCount: 5,
                            itemSize: 15.0,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.green,
                            )),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
