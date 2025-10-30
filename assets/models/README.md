# ML Model Instructions

## Adding the MobileNetV2.tfliteQuant Model

To use the PlantGuard app with real ML predictions, you need to add your `MobileNetV2.tfliteQuant` model file to this directory.

### Steps:

1. Place your `MobileNetV2.tfliteQuant` file in this directory (`assets/models/`)
2. The file should be named exactly `MobileNetV2.tfliteQuant`
3. Run `flutter pub get` to ensure the assets are properly included
4. The app will automatically load and use the model for plant disease detection

### Model Requirements:

- Input size: 224x224 pixels
- Input format: RGB float32 normalized to [0,1]
- Output: 38 classes (PlantVillage dataset)
- Quantized TensorFlow Lite model (.tflite)

### Testing:

Once the model is added, you can test the app by:
1. Running `flutter run`
2. Going to the camera screen
3. Taking a photo of a plant
4. The app will analyze the image and show disease predictions

### Note:

If no model is found, the app will show an error message when trying to analyze images. Make sure the model file is properly placed in this directory.
