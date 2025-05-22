import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  bool _isLoading = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;

  UserProvider() {
    _initUser();
  }

  Future<void> _initUser() async {
    _isLoading = true;
    notifyListeners();

    try {
      User? firebaseUser = _auth.currentUser;
      if (firebaseUser != null) {
        await _fetchUserData(firebaseUser.uid);
      }
    } catch (e) {
      debugPrint('Erro ao inicializar usuário: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _fetchUserData(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        _user = UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      debugPrint('Erro ao buscar dados do usuário: $e');
    }
  }

  // Login com ID e PIN
  Future<void> loginWithIdAndPin({required String id, required String pin}) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Buscar usuário pelo ID
      QuerySnapshot userQuery = await _firestore
          .collection('users')
          .where('gameName', isEqualTo: id)
          .limit(1)
          .get();

      if (userQuery.docs.isEmpty) {
        throw Exception('user-not-found');
      }

      // Verificar PIN
      DocumentSnapshot userDoc = userQuery.docs.first;
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      
      if (userData['pin'] != pin) {
        throw Exception('wrong-pin');
      }

      // Login com email/senha associados
      String email = userData['email'];
      String password = userData['password'] ?? pin; // Fallback para PIN como senha

      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Buscar dados completos
      await _fetchUserData(result.user!.uid);
      
      // Registrar login
      await _registerLoginActivity(result.user!.uid);
    } catch (e) {
      debugPrint('Erro no login: $e');
      throw Exception(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Login como admin (idcloned)
  Future<void> loginAsAdmin() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Buscar usuário admin
      QuerySnapshot adminQuery = await _firestore
          .collection('users')
          .where('isAdmin', isEqualTo: true)
          .limit(1)
          .get();

      if (adminQuery.docs.isEmpty) {
        // Criar usuário admin se não existir
        await _createAdminUser();
        return;
      }

      // Login com credenciais do admin
      DocumentSnapshot adminDoc = adminQuery.docs.first;
      Map<String, dynamic> adminData = adminDoc.data() as Map<String, dynamic>;
      
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: adminData['email'],
        password: adminData['password'] ?? 'admin123',
      );

      // Buscar dados completos
      await _fetchUserData(result.user!.uid);
      
      // Registrar login
      await _registerLoginActivity(result.user!.uid);
    } catch (e) {
      debugPrint('Erro no login admin: $e');
      throw Exception(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Criar usuário admin se não existir
  Future<void> _createAdminUser() async {
    try {
      // Criar usuário no Firebase Auth
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: 'admin@lamafia.com',
        password: 'admin123',
      );
      
      // Criar perfil do admin no Firestore
      UserModel adminUser = UserModel(
        uid: result.user!.uid,
        username: 'Administrador',
        email: 'admin@lamafia.com',
        gameName: 'idcloned',
        whatsapp: '',
        role: 'owner',
        level: 99,
        isAdmin: true,
        joinDate: DateTime.now().toIso8601String(),
      );
      
      await _firestore.collection('users').doc(result.user!.uid).set(adminUser.toMap());
      
      // Atualizar usuário atual
      _user = adminUser;
      
      // Registrar login
      await _registerLoginActivity(result.user!.uid);
    } catch (e) {
      debugPrint('Erro ao criar admin: $e');
      throw Exception(e.toString());
    }
  }

  // Registrar atividade de login
  Future<void> _registerLoginActivity(String uid) async {
    try {
      await _firestore.collection('user_activity').add({
        'userId': uid,
        'type': 'login',
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('Erro ao registrar atividade: $e');
    }
  }

  // Logout
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _auth.signOut();
      _user = null;
    } catch (e) {
      debugPrint('Erro ao fazer logout: $e');
      throw Exception(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Verificar se o usuário é admin ou dono
  Future<bool> isAdminOrOwner() async {
    if (_user == null) return false;
    return _user!.isAdmin || _user!.role == 'owner';
  }

  // Verificar se o usuário é o idcloned
  bool isIdCloned() {
    if (_user == null) return false;
    return _user!.gameName.toLowerCase() == 'idcloned';
  }

  // Atualizar dados do usuário
  Future<void> updateUserData(UserModel updatedUser) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _firestore.collection('users').doc(updatedUser.uid).update(updatedUser.toMap());
      _user = updatedUser;
    } catch (e) {
      debugPrint('Erro ao atualizar usuário: $e');
      throw Exception(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
