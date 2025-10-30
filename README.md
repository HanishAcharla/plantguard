# PlantGuard - AI-Powered Plant Disease Detection App

PlantGuard is a comprehensive Flutter application that uses machine learning to identify plant diseases from photos. The app provides a complete solution for plant disease management, including disease identification, treatment information, and community sharing.

## Features

### Authentication
- **Local User Management**: Create accounts and login without external dependencies
- **Secure Storage**: User data stored locally using SharedPreferences
- **Profile Management**: Update profile information and settings

### Core Functionality
- **AI Disease Detection**: Real-time plant disease identification using MobileNetV2
- **Camera Integration**: Take photos or select from gallery
- **Disease Database**: Browse 12+ common plant diseases with detailed information
- **Photo History**: Save and manage all scanned plant photos locally
- **Treatment Guides**: Comprehensive treatment and prevention information

### Disease Management
- **Disease Library**: 2-column grid layout with disease information
- **Detailed Disease Pages**: Scientific names, severity levels, and treatment options
- **Severity Classification**: High, Medium, Low risk levels with color coding
- **Treatment Information**: Step-by-step treatment and prevention guides

### Community Features
- **Blog Section**: Share articles about plant disease management
- **Success Stories**: Real-world experiences and solutions
- **Educational Content**: Prevention tips and organic treatment methods

### Settings & Personalization
- **Account Settings**: Profile photo, name, and preferences
- **Notification Settings**: Customizable alerts and tips
- **Dark Mode**: Theme switching capability
- **Data Management**: Export and manage saved photos

## Technical Architecture

###  App Structure
```
lib/
├── main.dart                 # App entry point
├── screens/                  # All app screens
│   ├── login_screen.dart    # Authentication
│   ├── home_screen.dart     # Main dashboard
│   ├── camera_screen.dart   # Photo capture & ML processing
│   ├── diseases_screen.dart # Disease database
│   ├── disease_detail_screen.dart # Disease information
│   ├── saved_photos_screen.dart  # Photo history
│   ├── blog_screen.dart     # Community articles
│   └── account_screen.dart  # User settings
├── services/                 # Business logic
│   ├── ml_service.dart      # ML model integration
│   └── local_storage_service.dart # Data persistence
└── assets/
    └── models/              # ML model files
```

### Machine Learning Integration
- **Model**: MobileNetV2.tfliteQuant (PlantVillage dataset)
- **Input**: 224x224 RGB images
- **Output**: 38 disease classes with confidence scores
- **Framework**: TensorFlow Lite Flutter
- **Processing**: Real-time image analysis

###  Data Storage
- **Local Storage**: SharedPreferences for user data
- **Photo Management**: Local file system storage
- **No External Dependencies**: Fully offline capable

## Installation & Setup

### Prerequisites
- Flutter SDK (3.9.2 or higher)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- Git

### Installation Steps

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd plantguard
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Add ML Model**
   - Place your `MobileNetV2.tfliteQuant` file in `assets/models/`
   - Ensure the file is named exactly `MobileNetV2.tfliteQuant`

4. **Run the App**
   ```bash
   flutter run
   ```

### Dependencies
```yaml
dependencies:
  flutter: sdk
  tflite_flutter: ^0.11.0    # ML model integration
  image_picker: ^1.2.0       # Camera functionality
  shared_preferences: ^2.5.3 # Local storage
  image: ^4.5.4              # Image processing
```

## Usage Guide

### Getting Started
1. **Create Account**: Sign up with email and password
2. **Login**: Use your credentials or try the demo account
3. **Home Screen**: Access all features from the main dashboard

### Scanning Plants
1. **Camera Screen**: Tap "Scan Plant Disease" on home screen
2. **Take Photo**: Use camera or select from gallery
3. **AI Analysis**: Wait for ML model to process the image
4. **View Results**: See disease name, confidence, and treatment info
5. **Save Photo**: Automatically saved to your photo history

### Browsing Diseases
1. **Diseases Tab**: Access the disease database
2. **Browse Grid**: 2-column layout with disease cards
3. **Disease Details**: Tap any disease for detailed information
4. **Treatment Info**: Learn about prevention and treatment

### Managing Photos
1. **My Photos Tab**: View all scanned photos
2. **Filter Options**: Filter by severity level
3. **Delete Photos**: Remove unwanted scans
4. **View Details**: Tap photos to see full disease information

### Community Features
1. **Blog Tab**: Read community articles
2. **Categories**: Filter by Success Story, Prevention, Treatment, etc.
3. **Detailed Articles**: Full articles with treatment guides
4. **Like & Comment**: Interact with community content

## ML Model Integration

### Model Requirements
- **Format**: TensorFlow Lite (.tflite)
- **Architecture**: MobileNetV2
- **Input Size**: 224x224 pixels
- **Classes**: 38 plant disease categories
- **Quantization**: INT8 quantized for mobile optimization

### Supported Diseases
The model can identify 38 different plant diseases including:
- Apple Scab, Black Rot, Cedar Apple Rust
- Common Rust, Early Blight, Late Blight
- Powdery Mildew, Leaf Mold, Septoria Leaf Spot
- Spider Mites, Target Spot, Yellow Leaf Curl Virus
- And many more...

### Performance
- **Inference Time**: ~2-3 seconds on mobile devices
- **Accuracy**: High accuracy on PlantVillage dataset
- **Offline**: No internet connection required
- **Privacy**: All processing happens locally

## Customization

### Adding New Diseases
1. Update `_plantVillageLabels` in `ml_service.dart`
2. Add disease information in `_getScientificName()` and `_getDiseaseDescription()`
3. Update severity levels in `_getSeverityLevel()`

### Modifying UI
- **Colors**: Update theme colors in `main.dart`
- **Layouts**: Modify screen widgets in `screens/` directory
- **Styling**: Customize Material Design components

### Adding Features
- **New Screens**: Add to `screens/` directory
- **Services**: Add business logic to `services/` directory
- **Storage**: Extend `local_storage_service.dart` for new data types

## Troubleshooting

### Common Issues

1. **ML Model Not Found**
   - Ensure `MobileNetV2.tfliteQuant` is in `assets/models/`
   - Run `flutter clean && flutter pub get`

2. **Camera Not Working**
   - Check device permissions
   - Ensure camera is not being used by another app

3. **App Crashes on Photo Analysis**
   - Verify model file integrity
   - Check device storage space
   - Ensure image format is supported

4. **Login Issues**
   - Clear app data and try again
   - Check if account exists in local storage

### Performance Optimization
- **Image Size**: App automatically resizes images to 224x224
- **Memory**: Large images are compressed before processing
- **Storage**: Old photos can be deleted to free space

## Future Enhancements

### Planned Features
- **Cloud Sync**: Optional cloud backup of photos
- **Expert Consultation**: Connect with plant pathologists
- **Garden Planning**: Disease-resistant garden layouts
- **Weather Integration**: Disease risk based on weather
- **Multi-language Support**: Localization for different regions

### Technical Improvements
- **Model Updates**: Support for newer ML models
- **Batch Processing**: Analyze multiple photos at once
- **Advanced Analytics**: Disease trend analysis
- **API Integration**: Connect with plant databases

## Contributing

### Development Setup
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

### Code Style
- Follow Flutter/Dart conventions
- Use meaningful variable names
- Add comments for complex logic
- Maintain consistent formatting

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions:
- Create an issue in the repository
- Check the troubleshooting section
- Review the documentation

## Acknowledgments

- **PlantVillage Dataset**: For providing the training data
- **TensorFlow Team**: For the ML framework
- **Flutter Team**: For the mobile framework
- **Community**: For feedback and contributions

---

**PlantGuard** - Protecting plants, one scan at a time!