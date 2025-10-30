import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _userKey = 'user_data';
  static const String _savedPhotosKey = 'saved_photos';
  static const String _isLoggedInKey = 'isLoggedIn';

  // User Management
  static Future<bool> createAccount({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Check if user already exists
      final existingUsers = prefs.getStringList('registered_users') ?? [];
      if (existingUsers.contains(email)) {
        return false; // User already exists
      }

      // Create user data
      final userData = {
        'email': email,
        'password': password, // In a real app, this should be hashed
        'name': name,
        'createdAt': DateTime.now().toIso8601String(),
      };

      // Save user data
      await prefs.setString(_userKey, jsonEncode(userData));
      
      // Add to registered users list
      existingUsers.add(email);
      await prefs.setStringList('registered_users', existingUsers);
      
      // Set as logged in
      await prefs.setBool(_isLoggedInKey, true);
      
      return true;
    } catch (e) {
      print('Error creating account: $e');
      return false;
    }
  }

  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Check if user exists in registered users
      final registeredUsers = prefs.getStringList('registered_users') ?? [];
      if (!registeredUsers.contains(email)) {
        return false; // User not found
      }

      // Get user data
      final userDataString = prefs.getString(_userKey);
      if (userDataString == null) {
        return false;
      }

      final userData = jsonDecode(userDataString) as Map<String, dynamic>;
      
      // Check password
      if (userData['password'] != password) {
        return false; // Wrong password
      }

      // Set as logged in
      await prefs.setBool(_isLoggedInKey, true);
      await prefs.setString('userEmail', email);
      
      return true;
    } catch (e) {
      print('Error during login: $e');
      return false;
    }
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, false);
    await prefs.remove('userEmail');
  }

  static Future<Map<String, dynamic>?> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userDataString = prefs.getString(_userKey);
      
      if (userDataString == null) return null;
      
      return jsonDecode(userDataString) as Map<String, dynamic>;
    } catch (e) {
      print('Error getting current user: $e');
      return null;
    }
  }

  // Saved Photos Management
  static Future<void> savePhoto({
    required String imagePath,
    required String diseaseName,
    required String scientificName,
    required double confidence,
    required String severity,
    required String description,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedPhotos = await getSavedPhotos();
      
      final newPhoto = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'imagePath': imagePath,
        'diseaseName': diseaseName,
        'scientificName': scientificName,
        'confidence': confidence,
        'severity': severity,
        'description': description,
        'date': DateTime.now().toIso8601String(),
      };
      
      savedPhotos.add(newPhoto);
      await prefs.setString(_savedPhotosKey, jsonEncode(savedPhotos));
    } catch (e) {
      print('Error saving photo: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getSavedPhotos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedPhotosString = prefs.getString(_savedPhotosKey);
      
      if (savedPhotosString == null) return [];
      
      final List<dynamic> photosList = jsonDecode(savedPhotosString);
      return photosList.cast<Map<String, dynamic>>();
    } catch (e) {
      print('Error getting saved photos: $e');
      return [];
    }
  }

  static Future<void> deletePhoto(String photoId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedPhotos = await getSavedPhotos();
      
      savedPhotos.removeWhere((photo) => photo['id'] == photoId);
      await prefs.setString(_savedPhotosKey, jsonEncode(savedPhotos));
    } catch (e) {
      print('Error deleting photo: $e');
    }
  }

  // Settings Management
  static Future<void> updateUserSettings({
    String? name,
    String? profileImagePath,
    bool? notificationsEnabled,
    bool? darkModeEnabled,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      if (name != null) {
        await prefs.setString('userName', name);
      }
      if (profileImagePath != null) {
        await prefs.setString('profileImagePath', profileImagePath);
      }
      if (notificationsEnabled != null) {
        await prefs.setBool('notificationsEnabled', notificationsEnabled);
      }
      if (darkModeEnabled != null) {
        await prefs.setBool('darkModeEnabled', darkModeEnabled);
      }
    } catch (e) {
      print('Error updating user settings: $e');
    }
  }

  static Future<Map<String, dynamic>> getUserSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      return {
        'userName': prefs.getString('userName') ?? 'Plant Guardian',
        'profileImagePath': prefs.getString('profileImagePath'),
        'notificationsEnabled': prefs.getBool('notificationsEnabled') ?? true,
        'darkModeEnabled': prefs.getBool('darkModeEnabled') ?? false,
      };
    } catch (e) {
      print('Error getting user settings: $e');
      return {
        'userName': 'Plant Guardian',
        'profileImagePath': null,
        'notificationsEnabled': true,
        'darkModeEnabled': false,
      };
    }
  }
}
