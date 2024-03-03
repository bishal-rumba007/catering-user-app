

import 'package:catering_user_app/src/features/auth/data/auth_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUser extends Mock implements User {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  final mockFirebaseAuth = MockFirebaseAuth();
  final AuthDataSource authDataSource = AuthDataSource(auth: mockFirebaseAuth);

  setUp(() {});
  tearDown(() {});

  test("Create account", () async {
    when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: "sanjaygrg@gmail.com", password: "Abc@1234"));

    expect(
      await authDataSource.createAccount(
          email: "sanjaygrg@gmail.com", password: "Abc@1234"),
      "Registration Successful",
    );
  });

  test("create account Exception", () async {
    when(
      mockFirebaseAuth.createUserWithEmailAndPassword(
          email: "sanjaygrg@gmail.com", password: "Abc@1234"),
    ).thenAnswer((realInvocation) =>
        throw FirebaseAuthException(message: "Error", code: "Error"));

    expect(
      await authDataSource.userSignup(
          fullName: "Sanjay Gurung",
          email: "sanjaygrg@gmail.com",
          phoneNumber: "1234567890",
          password: "Abc@1234"),
      "You Screwed Up",
    );
  });
}
