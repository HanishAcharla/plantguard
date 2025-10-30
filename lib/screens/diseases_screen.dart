import 'package:flutter/material.dart';
import 'disease_detail_screen.dart';

class DiseasesScreen extends StatefulWidget {
  const DiseasesScreen({super.key});

  @override
  State<DiseasesScreen> createState() => _DiseasesScreenState();
}

class _DiseasesScreenState extends State<DiseasesScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredDiseases = [];
  bool _isSearching = false;

  final List<Map<String, dynamic>> _diseases = [
    // Apple diseases
    {
      'name': 'Apple Scab',
      'scientificName': 'Venturia inaequalis',
      'image': 'assets/images/apple_scab.jpg',
      'severity': 'Medium',
      'description': 'Symptoms: Dark, scabby lesions on leaves and fruit, leaf yellowing.\n\nPrevention: Plant resistant varieties, ensure good air circulation, rake fallen leaves in fall.\n\nTreatment: Apply fungicides (captan, myclobutanil) during wet spring weather, remove infected leaves, prune to improve airflow.',
    },
    {
      'name': 'Apple Black Rot',
      'scientificName': 'Botryosphaeria obtusa',
      'image': 'assets/images/apple_black_rot.jpg',
      'severity': 'High',
      'description': 'Symptoms: Dark cankers on branches, fruit rot with concentric rings, leaf spots.\n\nPrevention: Prune dead wood, remove mummified fruit, plant resistant varieties, ensure good drainage.\n\nTreatment: Apply copper-based fungicides, remove infected plant parts, apply fungicide sprays every 7-10 days during wet periods.',
    },
    {
      'name': 'Apple Cedar Rust',
      'scientificName': 'Gymnosporangium juniperi-virginianae',
      'image': 'assets/images/apple_cedar_rust.jpg',
      'severity': 'Medium',
      'description': 'Symptoms: Orange spots on leaves, yellow lesions on fruit, premature leaf drop.\n\nPrevention: Remove nearby cedar trees, plant resistant apple varieties, maintain distance from junipers.\n\nTreatment: Apply fungicides (myclobutanil) before symptoms appear, repeat applications every 7-14 days, remove infected leaves.',
    },
    {
      'name': 'Apple Healthy',
      'scientificName': 'Malus domestica',
      'image': 'assets/images/apple_healthy.jpg',
      'severity': 'None',
      'description': 'Your plant appears healthy! Continue good practices: proper watering, adequate sunlight, regular fertilization, and monitoring for early signs of disease. Maintain good air circulation and remove any dead or damaged leaves promptly.',
    },
    
    // Blueberry diseases
    {
      'name': 'Blueberry Healthy',
      'scientificName': 'Vaccinium corymbosum',
      'image': 'assets/images/blueberry_healthy.jpg',
      'severity': 'None',
      'description': 'Your plant appears healthy! Continue good practices: proper watering, adequate sunlight, regular fertilization, and monitoring for early signs of disease. Maintain good air circulation and remove any dead or damaged leaves promptly.',
    },
    
    // Cherry diseases
    {
      'name': 'Cherry Powdery Mildew',
      'scientificName': 'Podosphaera clandestina',
      'image': 'assets/images/cherry_powdery_mildew.jpg',
      'severity': 'Medium',
      'description': 'Symptoms: White powdery coating on leaves, stunted growth, leaf curling.\n\nPrevention: Ensure good air circulation, avoid overhead watering, plant in full sun.\n\nTreatment: Spray with neem oil or sulfur fungicide, apply baking soda solution (1 tbsp per gallon), remove heavily infected leaves.',
    },
    {
      'name': 'Cherry Healthy',
      'scientificName': 'Prunus avium',
      'image': 'assets/images/cherry_healthy.jpg',
      'severity': 'None',
      'description': 'Your plant appears healthy! Continue good practices: proper watering, adequate sunlight, regular fertilization, and monitoring for early signs of disease. Maintain good air circulation and remove any dead or damaged leaves promptly.',
    },
    
    // Corn diseases
    {
      'name': 'Corn Cercospora Leaf Spot',
      'scientificName': 'Cercospora zeae-maydis',
      'image': 'assets/images/corn_cercospora_leaf_spot.jpg',
      'severity': 'Medium',
      'description': 'Symptoms: Rectangular gray spots, yellow halos, spots merge causing leaf death.\n\nPrevention: Rotate crops, plant resistant varieties, remove crop debris, ensure proper spacing.\n\nTreatment: Apply fungicides (azoxystrobin) at first sign, repeat every 14 days, remove infected leaves.',
    },
    {
      'name': 'Corn Common Rust',
      'scientificName': 'Puccinia sorghi',
      'image': 'assets/images/corn_common_rust.jpg',
      'severity': 'Low',
      'description': 'Symptoms: Small orange pustules on leaves, yellowing, reduced yield.\n\nPrevention: Plant resistant hybrids, practice crop rotation, remove crop debris.\n\nTreatment: Apply fungicides (azoxystrobin) at first sign, repeat every 14 days, ensure adequate plant nutrition.',
    },
    {
      'name': 'Corn Northern Leaf Blight',
      'scientificName': 'Exserohilum turcicum',
      'image': 'assets/images/corn_northern_leaf_blight.jpg',
      'severity': 'High',
      'description': 'Symptoms: Long elliptical gray-green lesions, leaf death, yield loss.\n\nPrevention: Plant resistant hybrids, rotate crops, remove crop debris, ensure proper plant nutrition.\n\nTreatment: Apply fungicides (azoxystrobin) at first sign, repeat applications as needed, improve field drainage.',
    },
    {
      'name': 'Corn Healthy',
      'scientificName': 'Zea mays',
      'image': 'assets/images/corn_healthy.jpg',
      'severity': 'None',
      'description': 'Your plant appears healthy! Continue good practices: proper watering, adequate sunlight, regular fertilization, and monitoring for early signs of disease. Maintain good air circulation and remove any dead or damaged leaves promptly.',
    },
    
    // Grape diseases
    {
      'name': 'Grape Black Rot',
      'scientificName': 'Guignardia bidwellii',
      'image': 'assets/images/grape_black_rot.jpg',
      'severity': 'High',
      'description': 'Symptoms: Dark cankers on branches, fruit rot with concentric rings, leaf spots.\n\nPrevention: Prune dead wood, remove mummified fruit, plant resistant varieties, ensure good drainage.\n\nTreatment: Apply copper-based fungicides, remove infected plant parts, apply fungicide sprays every 7-10 days during wet periods.',
    },
    {
      'name': 'Grape Esca',
      'scientificName': 'Phaeomoniella chlamydospora',
      'image': 'assets/images/grape_esca.jpg',
      'severity': 'High',
      'description': 'Symptoms: Tiger-stripe leaf pattern, berry spots, sudden plant collapse, wood decay.\n\nPrevention: Use clean pruning tools, avoid pruning wounds in wet weather, prune in dry conditions.\n\nTreatment: No cure - prune infected wood in summer, protect pruning wounds, remove severely infected vines.',
    },
    {
      'name': 'Grape Leaf Blight',
      'scientificName': 'Isariopsis griseola',
      'image': 'assets/images/grape_leaf_blight.jpg',
      'severity': 'Medium',
      'description': 'Symptoms: Angular brown spots, yellow halos, premature leaf drop, reduced vigor.\n\nPrevention: Ensure good air circulation, avoid overhead watering, remove fallen leaves, prune properly.\n\nTreatment: Apply copper fungicides or mancozeb, remove infected leaves, spray every 10-14 days during wet periods.',
    },
    {
      'name': 'Grape Healthy',
      'scientificName': 'Vitis vinifera',
      'image': 'assets/images/grape_healthy.jpg',
      'severity': 'None',
      'description': 'Your plant appears healthy! Continue good practices: proper watering, adequate sunlight, regular fertilization, and monitoring for early signs of disease. Maintain good air circulation and remove any dead or damaged leaves promptly.',
    },
    
    // Orange diseases
    {
      'name': 'Orange Huanglongbing',
      'scientificName': 'Candidatus Liberibacter',
      'image': 'assets/images/orange_huanglongbing.jpg',
      'severity': 'High',
      'description': 'Symptoms: Yellow shoots, blotchy mottled leaves, lopsided bitter fruit, tree decline.\n\nPrevention: Use certified disease-free trees, control Asian citrus psyllid, remove infected trees immediately.\n\nTreatment: No cure - remove infected trees, control psyllid with insecticides, inject antibiotics (limited effectiveness), plant resistant rootstocks.',
    },
    
    // Peach diseases
    {
      'name': 'Peach Bacterial Spot',
      'scientificName': 'Xanthomonas arboricola',
      'image': 'assets/images/peach_bacterial_spot.jpg',
      'severity': 'Medium',
      'description': 'Symptoms: Small dark spots with yellow halos, leaf drop, fruit lesions, reduced yield.\n\nPrevention: Use disease-free seeds, avoid overhead watering, rotate crops, ensure good drainage.\n\nTreatment: Apply copper-based bactericides, remove infected leaves, spray weekly during wet weather, improve air circulation.',
    },
    {
      'name': 'Peach Healthy',
      'scientificName': 'Prunus persica',
      'image': 'assets/images/peach_healthy.jpg',
      'severity': 'None',
      'description': 'Your plant appears healthy! Continue good practices: proper watering, adequate sunlight, regular fertilization, and monitoring for early signs of disease. Maintain good air circulation and remove any dead or damaged leaves promptly.',
    },
    
    // Pepper diseases
    {
      'name': 'Pepper Bacterial Spot',
      'scientificName': 'Xanthomonas spp.',
      'image': 'assets/images/pepper_bacterial_spot.jpg',
      'severity': 'Medium',
      'description': 'Symptoms: Small dark spots with yellow halos, leaf drop, fruit lesions, reduced yield.\n\nPrevention: Use disease-free seeds, avoid overhead watering, rotate crops, ensure good drainage.\n\nTreatment: Apply copper-based bactericides, remove infected leaves, spray weekly during wet weather, improve air circulation.',
    },
    {
      'name': 'Pepper Healthy',
      'scientificName': 'Capsicum annuum',
      'image': 'assets/images/pepper_healthy.jpg',
      'severity': 'None',
      'description': 'Your plant appears healthy! Continue good practices: proper watering, adequate sunlight, regular fertilization, and monitoring for early signs of disease. Maintain good air circulation and remove any dead or damaged leaves promptly.',
    },
    
    // Potato diseases
    {
      'name': 'Potato Early Blight',
      'scientificName': 'Alternaria solani',
      'image': 'assets/images/potato_early_blight.jpg',
      'severity': 'Medium',
      'description': 'Symptoms: Dark brown spots with concentric rings, lower leaves affected first, yellowing.\n\nPrevention: Rotate crops (3-year cycle), mulch plants, water at base, stake plants for airflow.\n\nTreatment: Apply copper fungicides or chlorothalonil weekly, remove infected leaves, improve air circulation.',
    },
    {
      'name': 'Potato Late Blight',
      'scientificName': 'Phytophthora infestans',
      'image': 'assets/images/potato_late_blight.jpg',
      'severity': 'High',
      'description': 'Symptoms: Water-soaked lesions, white fungal growth, rapid plant collapse, fruit rot.\n\nPrevention: Plant certified disease-free seeds, ensure proper spacing, avoid overhead watering.\n\nTreatment: Apply fungicides (chlorothalonil, mancozeb) immediately, remove infected plants, destroy (don\'t compost) all infected material.',
    },
    {
      'name': 'Potato Healthy',
      'scientificName': 'Solanum tuberosum',
      'image': 'assets/images/potato_healthy.jpg',
      'severity': 'None',
      'description': 'Your plant appears healthy! Continue good practices: proper watering, adequate sunlight, regular fertilization, and monitoring for early signs of disease. Maintain good air circulation and remove any dead or damaged leaves promptly.',
    },
    
    // Raspberry diseases
    {
      'name': 'Raspberry Healthy',
      'scientificName': 'Rubus idaeus',
      'image': 'assets/images/raspberry_healthy.jpg',
      'severity': 'None',
      'description': 'Your plant appears healthy! Continue good practices: proper watering, adequate sunlight, regular fertilization, and monitoring for early signs of disease. Maintain good air circulation and remove any dead or damaged leaves promptly.',
    },
    
    // Soybean diseases
    {
      'name': 'Soybean Healthy',
      'scientificName': 'Glycine max',
      'image': 'assets/images/soybean_healthy.jpg',
      'severity': 'None',
      'description': 'Your plant appears healthy! Continue good practices: proper watering, adequate sunlight, regular fertilization, and monitoring for early signs of disease. Maintain good air circulation and remove any dead or damaged leaves promptly.',
    },
    
    // Squash diseases
    {
      'name': 'Squash Powdery Mildew',
      'scientificName': 'Erysiphe cichoracearum',
      'image': 'assets/images/squash_powdery_mildew.jpg',
      'severity': 'Low',
      'description': 'Symptoms: White powdery coating on leaves, stunted growth, leaf curling.\n\nPrevention: Ensure good air circulation, avoid overhead watering, plant in full sun.\n\nTreatment: Spray with neem oil or sulfur fungicide, apply baking soda solution (1 tbsp per gallon), remove heavily infected leaves.',
    },
    
    // Strawberry diseases
    {
      'name': 'Strawberry Leaf Scorch',
      'scientificName': 'Diplocarpon earlianum',
      'image': 'assets/images/strawberry_leaf_scorch.jpg',
      'severity': 'Medium',
      'description': 'Symptoms: Purple or red leaf margins, brown spots, leaf browning from edges.\n\nPrevention: Ensure proper watering, mulch plants, plant in well-draining soil, avoid water stress.\n\nTreatment: Remove infected leaves, ensure consistent moisture, apply fungicides if fungal, improve drainage and irrigation.',
    },
    {
      'name': 'Strawberry Healthy',
      'scientificName': 'Fragaria × ananassa',
      'image': 'assets/images/strawberry_healthy.jpg',
      'severity': 'None',
      'description': 'Your plant appears healthy! Continue good practices: proper watering, adequate sunlight, regular fertilization, and monitoring for early signs of disease. Maintain good air circulation and remove any dead or damaged leaves promptly.',
    },
    
    // Tomato diseases
    {
      'name': 'Tomato Bacterial Spot',
      'scientificName': 'Xanthomonas spp.',
      'image': 'assets/images/tomato_bacterial_spot.jpg',
      'severity': 'Medium',
      'description': 'Symptoms: Small dark spots with yellow halos, leaf drop, fruit lesions, reduced yield.\n\nPrevention: Use disease-free seeds, avoid overhead watering, rotate crops, ensure good drainage.\n\nTreatment: Apply copper-based bactericides, remove infected leaves, spray weekly during wet weather, improve air circulation.',
    },
    {
      'name': 'Tomato Early Blight',
      'scientificName': 'Alternaria solani',
      'image': 'assets/images/tomato_early_blight.jpg',
      'severity': 'Medium',
      'description': 'Symptoms: Dark brown spots with concentric rings, lower leaves affected first, yellowing.\n\nPrevention: Rotate crops (3-year cycle), mulch plants, water at base, stake plants for airflow.\n\nTreatment: Apply copper fungicides or chlorothalonil weekly, remove infected leaves, improve air circulation.',
    },
    {
      'name': 'Tomato Late Blight',
      'scientificName': 'Phytophthora infestans',
      'image': 'assets/images/tomato_late_blight.jpg',
      'severity': 'High',
      'description': 'Symptoms: Water-soaked lesions, white fungal growth, rapid plant collapse, fruit rot.\n\nPrevention: Plant certified disease-free seeds, ensure proper spacing, avoid overhead watering.\n\nTreatment: Apply fungicides (chlorothalonil, mancozeb) immediately, remove infected plants, destroy (don\'t compost) all infected material.',
    },
    {
      'name': 'Tomato Leaf Mold',
      'scientificName': 'Passalora fulva',
      'image': 'assets/images/tomato_leaf_mold.jpg',
      'severity': 'Medium',
      'description': 'Symptoms: Yellow spots on upper leaf surface, olive-green mold below, leaf drop.\n\nPrevention: Reduce humidity, improve ventilation, avoid wetting foliage, space plants properly.\n\nTreatment: Apply fungicides (chlorothalonil), remove infected leaves, reduce humidity to below 85%.',
    },
    {
      'name': 'Tomato Septoria Leaf Spot',
      'scientificName': 'Septoria lycopersici',
      'image': 'assets/images/tomato_septoria_leaf_spot.jpg',
      'severity': 'Medium',
      'description': 'Symptoms: Small circular spots with gray centers, dark borders, lower leaves affected.\n\nPrevention: Rotate crops, mulch to prevent soil splash, water at plant base, remove debris.\n\nTreatment: Apply copper-based fungicides or chlorothalonil, remove infected leaves immediately, stake plants off ground.',
    },
    {
      'name': 'Tomato Spider Mites',
      'scientificName': 'Tetranychus urticae',
      'image': 'assets/images/tomato_spider_mites.jpg',
      'severity': 'Low',
      'description': 'Symptoms: Yellow stippling on leaves, fine webbing, leaf bronzing, plant stress.\n\nPrevention: Keep plants well-watered, spray leaves with water, encourage beneficial insects.\n\nTreatment: Spray with insecticidal soap or neem oil, introduce predatory mites, use miticides for severe cases, repeat treatments every 3-5 days.',
    },
    {
      'name': 'Tomato Target Spot',
      'scientificName': 'Corynespora cassiicola',
      'image': 'assets/images/tomato_target_spot.jpg',
      'severity': 'Medium',
      'description': 'Symptoms: Circular spots with concentric rings, brown lesions, leaf yellowing.\n\nPrevention: Practice crop rotation, remove plant debris, ensure good air circulation.\n\nTreatment: Apply fungicides (azoxystrobin, chlorothalonil), remove infected leaves, water at plant base only.',
    },
    {
      'name': 'Tomato Yellow Leaf Curl Virus',
      'scientificName': 'Begomovirus',
      'image': 'assets/images/tomato_yellow_leaf_curl_virus.jpg',
      'severity': 'High',
      'description': 'Symptoms: Upward leaf curling, yellowing between veins, stunted growth, reduced fruit.\n\nPrevention: Use reflective mulch, install insect screens, remove infected plants immediately, plant resistant varieties.\n\nTreatment: No cure available - remove infected plants, control whiteflies with insecticidal soap, prevent spread to healthy plants.',
    },
    {
      'name': 'Tomato Mosaic Virus',
      'scientificName': 'Tobamovirus',
      'image': 'assets/images/tomato_mosaic_virus.jpg',
      'severity': 'High',
      'description': 'Symptoms: Mottled light/dark green leaves, leaf distortion, stunted growth, reduced yield.\n\nPrevention: Use disease-free seeds, disinfect tools, wash hands after smoking, plant resistant varieties.\n\nTreatment: No cure - remove infected plants immediately, disinfect all tools with 10% bleach solution, don\'t compost infected material.',
    },
    {
      'name': 'Tomato Healthy',
      'scientificName': 'Solanum lycopersicum',
      'image': 'assets/images/tomato_healthy.jpg',
      'severity': 'None',
      'description': 'Your plant appears healthy! Continue good practices: proper watering, adequate sunlight, regular fertilization, and monitoring for early signs of disease. Maintain good air circulation and remove any dead or damaged leaves promptly.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _filteredDiseases = _diseases;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _isSearching = query.isNotEmpty;
      if (query.isEmpty) {
        _filteredDiseases = _diseases;
      } else {
        _filteredDiseases = _diseases.where((disease) {
          return disease['name'].toLowerCase().contains(query) ||
                 disease['scientificName'].toLowerCase().contains(query) ||
                 disease['description'].toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  void _clearSearch() {
    _searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Diseases'),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2E7D32),
              Color(0xFF4CAF50),
            ],
          ),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Icon(
                    Icons.eco,
                    size: 48,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Plant Disease Database',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Explore ${_filteredDiseases.length} common plant diseases',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search diseases...',
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF2E7D32)),
                  suffixIcon: _isSearching
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Color(0xFF2E7D32)),
                          onPressed: _clearSearch,
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Diseases Grid
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: _filteredDiseases.isEmpty
                    ? _buildNoResults()
                    : Padding(
                        padding: const EdgeInsets.all(16),
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: _filteredDiseases.length,
                          itemBuilder: (context, index) {
                            final disease = _filteredDiseases[index];
                            return _buildDiseaseCard(disease, index);
                          },
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiseaseCard(Map<String, dynamic> disease, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DiseaseDetailScreen(
              diseaseName: disease['name'],
              scientificName: disease['scientificName'],
              description: disease['description'],
              severity: disease['severity'],
              imagePath: disease['image'],
              isFromCamera: false,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.asset(
                  disease['image'],
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback if image doesn't exist
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: _getSeverityColor(disease['severity']).withOpacity(0.1),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.eco,
                              size: 40,
                              color: _getSeverityColor(disease['severity']),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                disease['name'],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: _getSeverityColor(disease['severity']),
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            
            // Content
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      disease['name'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      disease['scientificName'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getSeverityColor(disease['severity']),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            disease['severity'],
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: Colors.grey[400],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No diseases found',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try searching with different keywords',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _clearSearch,
            icon: const Icon(Icons.clear),
            label: const Text('Clear Search'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D32),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      case 'none':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
