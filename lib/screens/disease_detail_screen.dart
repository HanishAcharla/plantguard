import 'package:flutter/material.dart';
import 'dart:io';

class DiseaseDetailScreen extends StatefulWidget {
  final String diseaseName;
  final String scientificName;
  final String? description;
  final String? severity;
  final String? imagePath;
  final bool isFromCamera;
  final double? confidence;

  const DiseaseDetailScreen({
    super.key,
    required this.diseaseName,
    required this.scientificName,
    this.description,
    this.severity,
    this.imagePath,
    this.isFromCamera = false,
    this.confidence,
  });

  @override
  State<DiseaseDetailScreen> createState() => _DiseaseDetailScreenState();
}

class _DiseaseDetailScreenState extends State<DiseaseDetailScreen> {
  bool _isSaved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.diseaseName),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(_isSaved ? Icons.bookmark : Icons.bookmark_border),
            onPressed: () {
              setState(() {
                _isSaved = !_isSaved;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_isSaved ? 'Saved to favorites' : 'Removed from favorites'),
                  backgroundColor: const Color(0xFF2E7D32),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
                ),
              ),
              child: widget.imagePath != null && widget.imagePath!.startsWith('/')
                  ? Image.file(
                      File(widget.imagePath!),
                      fit: BoxFit.cover,
                    )
                  : widget.imagePath != null && widget.imagePath!.startsWith('assets/')
                      ? Image.asset(
                          widget.imagePath!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                              ),
                              child: const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.eco,
                                      size: 80,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Plant Disease',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                          ),
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.eco,
                                  size: 80,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Plant Disease',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Disease Name and Scientific Name
                  Text(
                    widget.diseaseName,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.scientificName,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Confidence Score (if from camera)
                  if (widget.isFromCamera && widget.confidence != null) ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E7D32).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF2E7D32).withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.psychology,
                            color: Color(0xFF2E7D32),
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'AI Confidence',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2E7D32),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${(widget.confidence! * 100).toStringAsFixed(1)}%',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2E7D32),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Severity
                  if (widget.severity != null) ...[
                    _buildInfoCard(
                      'Risk Severity',
                      widget.severity!,
                      _getSeverityIcon(widget.severity!),
                      _getSeverityColor(widget.severity!),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Description
                  if (widget.description != null) ...[
                    _buildInfoCard(
                      'Description',
                      widget.description!,
                      Icons.info_outline,
                      const Color(0xFF2E7D32),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Treatment Information
                  _buildInfoCard(
                    'Treatment & Prevention',
                    _getTreatmentInfo(widget.diseaseName),
                    Icons.healing,
                    const Color(0xFF4CAF50),
                  ),
                  const SizedBox(height: 20),

                  // Additional Tips
                  _buildInfoCard(
                    'Additional Tips',
                    _getAdditionalTips(widget.diseaseName),
                    Icons.lightbulb_outline,
                    const Color(0xFFFF9800),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String content, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getSeverityIcon(String severity) {
    switch (severity.toLowerCase()) {
      case 'high':
        return Icons.warning;
      case 'medium':
        return Icons.info;
      case 'low':
        return Icons.check_circle;
      default:
        return Icons.help;
    }
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _getTreatmentInfo(String diseaseName) {
    switch (diseaseName.toLowerCase()) {
      case 'apple scab':
        return '• Apply fungicides in early spring before bud break\n• Remove fallen leaves and debris\n• Prune to improve air circulation\n• Use resistant varieties when possible';
      case 'black rot':
        return '• Remove infected fruit and cankers\n• Apply fungicides during bloom\n• Improve air circulation\n• Avoid overhead watering';
      case 'cedar apple rust':
        return '• Remove nearby cedar trees if possible\n• Apply fungicides in spring\n• Use resistant apple varieties\n• Prune to improve air flow';
      case 'common rust':
        return '• Apply fungicides when symptoms first appear\n• Remove infected plant debris\n• Rotate crops\n• Use resistant varieties';
      case 'early blight':
        return '• Apply fungicides preventively\n• Remove infected leaves\n• Avoid overhead watering\n• Rotate crops regularly';
      case 'late blight':
        return '• Apply fungicides immediately\n• Remove infected plants\n• Improve air circulation\n• Avoid overhead watering';
      case 'leaf mold':
        return '• Reduce humidity in greenhouse\n• Apply fungicides\n• Remove infected leaves\n• Improve air circulation';
      case 'powdery mildew':
        return '• Apply fungicides or baking soda solution\n• Remove infected plant parts\n• Improve air circulation\n• Avoid overhead watering';
      case 'septoria leaf spot':
        return '• Apply fungicides preventively\n• Remove infected leaves\n• Avoid overhead watering\n• Rotate crops';
      case 'spider mites':
        return '• Apply insecticidal soap or neem oil\n• Increase humidity\n• Remove heavily infested leaves\n• Use predatory mites';
      case 'target spot':
        return '• Apply fungicides\n• Remove infected plant debris\n• Improve air circulation\n• Avoid overhead watering';
      case 'yellow leaf curl virus':
        return '• Control whitefly populations\n• Remove infected plants\n• Use resistant varieties\n• Apply insecticides if necessary';
      default:
        return '• Consult with a plant pathologist\n• Apply appropriate fungicides\n• Improve growing conditions\n• Remove infected plant material';
    }
  }

  String _getAdditionalTips(String diseaseName) {
    return '• Monitor plants regularly for early signs\n• Maintain proper plant spacing\n• Water at the base of plants\n• Keep garden tools clean\n• Consider using organic treatments first';
  }
}
