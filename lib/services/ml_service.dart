import 'dart:io';
import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class MLService {
  static Interpreter? _interpreter;
  static List<String> _labels = [];
  
  // PlantVillage dataset labels (38 classes)
  static const List<String> _plantVillageLabels = [
    'Apple___Apple_scab',
    'Apple___Black_rot',
    'Apple___Cedar_apple_rust',
    'Apple___healthy',
    'Blueberry___healthy',
    'Cherry_(including_sour)___Powdery_mildew',
    'Cherry_(including_sour)___healthy',
    'Corn_(maize)___Cercospora_leaf_spot Gray_leaf_spot',
    'Corn_(maize)___Common_rust_',
    'Corn_(maize)___Northern_Leaf_Blight',
    'Corn_(maize)___healthy',
    'Grape___Black_rot',
    'Grape___Esca_(Black_Measles)',
    'Grape___Leaf_blight_(Isariopsis_Leaf_Spot)',
    'Grape___healthy',
    'Orange___Haunglongbing_(Citrus_greening)',
    'Peach___Bacterial_spot',
    'Peach___healthy',
    'Pepper,_bell___Bacterial_spot',
    'Pepper,_bell___healthy',
    'Potato___Early_blight',
    'Potato___Late_blight',
    'Potato___healthy',
    'Raspberry___healthy',
    'Soybean___healthy',
    'Squash___Powdery_mildew',
    'Strawberry___Leaf_scorch',
    'Strawberry___healthy',
    'Tomato___Bacterial_spot',
    'Tomato___Early_blight',
    'Tomato___Late_blight',
    'Tomato___Leaf_Mold',
    'Tomato___Septoria_leaf_spot',
    'Tomato___Spider_mites Two-spotted_spider_mite',
    'Tomato___Target_Spot',
    'Tomato___Tomato_Yellow_Leaf_Curl_Virus',
    'Tomato___Tomato_mosaic_virus',
    'Tomato___healthy'
  ];

  static Future<void> initialize() async {
    try {
      // Load the model
      _interpreter = await Interpreter.fromAsset('assets/models/MobileNetV2.tfliteQuant');
      
      // Set labels
      _labels = _plantVillageLabels;
      
      print('ML Model loaded successfully');
      
    } catch (e) {
      print('Error loading ML model: $e');
      throw Exception('Failed to load ML model: $e');
    }
  }

  static Future<Map<String, dynamic>?> predictDisease(String imagePath) async {
    if (_interpreter == null) {
      await initialize();
    }

    try {
      // Load and preprocess image
      final imageBytes = await File(imagePath).readAsBytes();
      final image = img.decodeImage(imageBytes);
      
      if (image == null) {
        throw Exception('Could not decode image');
      }

      // Resize image to 224x224 (MobileNetV2 input size)
      final resizedImage = img.copyResize(image, width: 224, height: 224);
      
      // Convert to float32 array and normalize
      final input = _imageToFloat32List(resizedImage);
      
      // Prepare input tensor
      final inputTensor = [input];
      
      // Prepare output tensor
      final output = List.filled(1 * _labels.length, 0.0).reshape([1, _labels.length]);
      
      // Run inference
      _interpreter!.run(inputTensor, output);
      
      // Get predictions
      final predictions = output[0] as List<double>;
      
      // Debug: Print raw predictions
      print('Raw predictions (first 5): ${predictions.take(5).toList()}');
      print('Raw predictions range: ${predictions.reduce((a, b) => a < b ? a : b)} to ${predictions.reduce((a, b) => a > b ? a : b)}');
      print('Sum of all predictions: ${predictions.reduce((a, b) => a + b)}');
      
      // Based on your Python code, the model likely outputs probabilities directly
      // Let's try using the raw predictions first (like your Python code)
      List<double> finalPredictions = predictions;
      
      // Find the highest confidence prediction
      int maxIndex = 0;
      double maxConfidence = finalPredictions[0];
      
      for (int i = 1; i < finalPredictions.length; i++) {
        if (finalPredictions[i] > maxConfidence) {
          maxConfidence = finalPredictions[i];
          maxIndex = i;
        }
      }
      
      // Debug: Print confidence scores
      print('Max confidence: ${(maxConfidence * 100).toStringAsFixed(2)}%');
      print('Top 5 predictions:');
      final sortedIndices = List.generate(finalPredictions.length, (i) => i)
          ..sort((a, b) => finalPredictions[b].compareTo(finalPredictions[a]));
      
      for (int i = 0; i < 5 && i < sortedIndices.length; i++) {
        final idx = sortedIndices[i];
        print('  ${_labels[idx]}: ${(finalPredictions[idx] * 100).toStringAsFixed(2)}%');
      }
      
      // Get disease name and format it
      final rawDiseaseName = _labels[maxIndex];
      final formattedDiseaseName = _formatDiseaseName(rawDiseaseName);
      
      return {
        'diseaseName': formattedDiseaseName,
        'scientificName': _getScientificName(formattedDiseaseName),
        'confidence': maxConfidence,
        'severity': _getSeverityLevel(formattedDiseaseName),
        'description': _getDiseaseDescription(formattedDiseaseName),
      };
    } catch (e) {
      print('Error during prediction: $e');
      return null;
    }
  }

  static List<List<List<double>>> _imageToFloat32List(img.Image image) {
    final input = List.generate(224, (i) => 
      List.generate(224, (j) => 
        List.generate(3, (k) => 0.0)
      )
    );

    for (int i = 0; i < 224; i++) {
      for (int j = 0; j < 224; j++) {
        final pixel = image.getPixel(j, i);
        input[i][j][0] = pixel.r / 255.0;   // R
        input[i][j][1] = pixel.g / 255.0;   // G
        input[i][j][2] = pixel.b / 255.0;   // B
      }
    }

    return input;
  }

  static double _sigmoid(double x) {
    return 1 / (1 + exp(x * -1));
  }

  static List<double> _softmax(List<double> logits) {
    // Find the maximum value for numerical stability
    final maxLogit = logits.reduce((a, b) => a > b ? a : b);
    
    // Calculate exponentials
    final expLogits = logits.map((x) => exp(x - maxLogit)).toList();
    
    // Calculate sum of exponentials
    final sumExp = expLogits.reduce((a, b) => a + b);
    
    // Calculate softmax probabilities
    return expLogits.map((x) => x / sumExp).toList();
  }

  static String _formatDiseaseName(String rawName) {
    // Convert from "Plant___Disease" format to "Disease" format
    if (rawName.contains('___')) {
      final parts = rawName.split('___');
      if (parts.length > 1) {
        return parts[1].replaceAll('_', ' ');
      }
    }
    return rawName.replaceAll('_', ' ');
  }

  static String _getScientificName(String diseaseName) {
    // Map common disease names to scientific names
    final scientificNames = {
      'Apple scab': 'Venturia inaequalis',
      'Black rot': 'Botryosphaeria obtusa',
      'Cedar apple rust': 'Gymnosporangium juniperi-virginianae',
      'Common rust': 'Puccinia sorghi',
      'Northern Leaf Blight': 'Exserohilum turcicum',
      'Cercospora leaf spot Gray leaf spot': 'Cercospora zeae-maydis',
      'Esca (Black Measles)': 'Phaeomoniella chlamydospora',
      'Leaf blight (Isariopsis Leaf Spot)': 'Isariopsis griseola',
      'Haunglongbing (Citrus greening)': 'Candidatus Liberibacter',
      'Bacterial spot': 'Xanthomonas spp.',
      'Early blight': 'Alternaria solani',
      'Late blight': 'Phytophthora infestans',
      'Powdery mildew': 'Erysiphe cichoracearum',
      'Leaf scorch': 'Diplocarpon earlianum',
      'Leaf Mold': 'Passalora fulva',
      'Septoria leaf spot': 'Septoria lycopersici',
      'Spider mites Two-spotted spider mite': 'Tetranychus urticae',
      'Target Spot': 'Corynespora cassiicola',
      'Tomato Yellow Leaf Curl Virus': 'Begomovirus',
      'Tomato mosaic virus': 'Tobamovirus',
    };
    
    return scientificNames[diseaseName] ?? 'Unknown';
  }

  static String _getSeverityLevel(String diseaseName) {
    // Map diseases to severity levels
    final highSeverity = [
      'Late blight',
      'Tomato Yellow Leaf Curl Virus',
      'Tomato mosaic virus',
      'Haunglongbing (Citrus greening)',
    ];
    
    final mediumSeverity = [
      'Apple scab',
      'Black rot',
      'Cedar apple rust',
      'Early blight',
      'Leaf Mold',
      'Septoria leaf spot',
      'Target Spot',
      'Bacterial spot',
    ];
    
    if (highSeverity.contains(diseaseName)) {
      return 'High';
    } else if (mediumSeverity.contains(diseaseName)) {
      return 'Medium';
    } else {
      return 'Low';
    }
  }

  static String _getDiseaseDescription(String diseaseName) {
    final descriptions = {
      'Apple scab': 'A fungal disease that causes dark, scabby lesions on apple leaves and fruit.',
      'Black rot': 'A serious fungal disease that causes cankers on branches and fruit rot.',
      'Cedar apple rust': 'A fungal disease that requires both apple and cedar trees to complete its life cycle.',
      'Common rust': 'A fungal disease that affects corn plants, causing orange pustules on leaves.',
      'Early blight': 'A fungal disease that affects tomatoes and potatoes, causing dark spots on leaves.',
      'Late blight': 'A devastating fungal disease that can quickly destroy entire crops.',
      'Powdery mildew': 'A fungal disease that creates a white, powdery coating on plant surfaces.',
      'Leaf Mold': 'A fungal disease that causes yellow spots and mold growth on tomato leaves.',
      'Septoria leaf spot': 'A fungal disease that causes small, dark spots on tomato leaves.',
      'Spider mites Two-spotted spider mite': 'Tiny arachnids that feed on plant sap, causing yellowing and webbing.',
      'Target Spot': 'A fungal disease that causes circular, target-like spots on leaves.',
      'Tomato Yellow Leaf Curl Virus': 'A viral disease transmitted by whiteflies that causes yellowing and curling of leaves.',
      'Tomato mosaic virus': 'A viral disease that causes mosaic patterns and stunting in tomato plants.',
      'Bacterial spot': 'A bacterial disease that causes small, dark spots on leaves and fruit.',
    };
    
    return descriptions[diseaseName] ?? 'A plant disease that requires attention and treatment.';
  }

  static void dispose() {
    _interpreter?.close();
    _interpreter = null;
  }
}
