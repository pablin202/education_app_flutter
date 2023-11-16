import 'package:education_app_flutter/core/enums/update_user.dart';
import 'package:education_app_flutter/src/auth/data/data/auth_remote_data_source.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';

void main() {
  late FakeFirebaseFirestore cloudStoreClient;
  late MockFirebaseAuth authClient;
  late MockFirebaseStorage dbClient;
  late AuthRemoteDataSource dataSource;

  setUp(() async {
    cloudStoreClient = FakeFirebaseFirestore();

    final googleSignIn = MockGoogleSignIn();
    final signInAccount = await googleSignIn.signIn();
    final googleAuth = await signInAccount?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Sign in.
    final mockUser = MockUser(
      uid: 'someuid',
      email: 'bob@somedomain.com',
      displayName: 'Bob',
    );
    authClient = MockFirebaseAuth(mockUser: mockUser);
    //final result = await authClient.signInWithCredential(credential);
    //final user = result.user;

    dbClient = MockFirebaseStorage();
    dataSource = AuthRemoteDataSourceImpl(
      authClient: authClient,
      cloudStoreClient: cloudStoreClient,
      dbClient: dbClient,
    );
  });

  test('signUp', () async {
    await dataSource.signUp(
      email: fakeEmail,
      fullName: fakeFullName,
      password: fakePassword,
    );

    expect(authClient.currentUser, isNotNull);
    expect(authClient.currentUser!.displayName, fakeFullName);

    final user = await cloudStoreClient
        .collection('users')
        .doc(
          authClient.currentUser!.uid,
        )
        .get();

    expect(user.exists, isTrue);
  });

  test('signIn', () async {
    await dataSource.signUp(
      email: fakeEmail,
      fullName: fakeFullName,
      password: fakePassword,
    );

    await authClient.signOut();

    await dataSource.signIn(email: fakeEmail, password: fakePassword);

    expect(authClient.currentUser, isNotNull);
    expect(authClient.currentUser!.email, fakeEmail);
  });

  group('updateUser', () {
    test('displayName', () async {
      await dataSource.signUp(
        email: fakeEmail,
        fullName: fakeFullName,
        password: fakePassword,
      );

      await dataSource.updateUser(
        action: UpdateUserAction.displayName,
        userData: 'new name',
      );

      expect(authClient.currentUser!.displayName, 'new name');


    });

    test('email', () async {

      await dataSource.signUp(
        email: fakeEmail,
        fullName: fakeFullName,
        password: fakePassword,
      );

      await dataSource.updateUser(
        action: UpdateUserAction.email,
        userData: 'newemail@mail.com',
      );

      expect(authClient.currentUser!.email, 'newemail@mail.com');

    });
  });
}

const fakePassword = '123456';
const fakeFullName = 'mail@mail.com';
const fakeEmail = 'Paul Mol';
