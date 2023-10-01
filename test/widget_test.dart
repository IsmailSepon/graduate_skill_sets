import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gp/auth/model/skill_model.dart';
import 'package:gp/auth/model/university_model.dart';
import 'package:gp/firestore/firestore_services.dart'; // Import your authentication service
import 'package:mockito/mockito.dart';


class MockFireStoreService extends Mock implements FireStoreService {}

void main() {
  group('registerWithEmailAndPassword', () {
    test('getUniversity', () async {
      final mockFireStoreService = MockFireStoreService();

      // Mock the behavior of getUniversityList
      when(mockFireStoreService.getUniversityList()).thenAnswer((_) async {
        // Return a sample list of universities
        return [
          const University(id: '1', name: 'University A'),
          const University(id: '2', name: 'University B'),
          // Add more universities as needed
        ];
      });

      // Call the method you want to test
      final result = await mockFireStoreService.getUniversityList();

      // Expect the result to be a list of universities
      expect(result, isA<List<University>>());

      // You can also check specific elements in the list if needed
      expect(result, hasLength(2)); // Assuming two universities were returned
      expect(result[0].name, 'University A');
      expect(result[1].name, 'University B');
    });

    test('getSkill', () async {
      final mockFireStoreService = MockFireStoreService();

      // Mock the behavior of getUniversityList
      when(mockFireStoreService.getSkillNameList()).thenAnswer((_) async {
        // Return a sample list of universities
        return [
          const SkillModel(id: '1', name: 'Skill A'),
          const SkillModel(id: '2', name: 'Skill B'),
          // Add more universities as needed
        ];
      });

      // Call the method you want to test
      final result = await mockFireStoreService.getSkillNameList();

      // Expect the result to be a list of universities
      expect(result, isA<List<University>>());

      // You can also check specific elements in the list if needed
      expect(result, hasLength(2)); // Assuming two universities were returned
      expect(result[0].name, 'skill A');
      expect(result[1].name, 'skill B');
    });





  });
}
