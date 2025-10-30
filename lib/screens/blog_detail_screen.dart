import 'package:flutter/material.dart';

class BlogDetailScreen extends StatefulWidget {
  final Map<String, dynamic> post;

  const BlogDetailScreen({
    super.key,
    required this.post,
  });

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  bool _isLiked = false;
  int _likeCount = 0;

  @override
  void initState() {
    super.initState();
    _likeCount = widget.post['likes'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Story'),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Implement share functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: _getCategoryColor(widget.post['category']).withOpacity(0.1),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.article,
                      size: 80,
                      color: _getCategoryColor(widget.post['category']),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.post['title'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _getCategoryColor(widget.post['category']),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category and Read Time
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getCategoryColor(widget.post['category']),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          widget.post['category'],
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.post['readTime'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Title
                  Text(
                    widget.post['title'],
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Author and Date
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: _getCategoryColor(widget.post['category']).withOpacity(0.2),
                        child: Text(
                          widget.post['author'][0],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _getCategoryColor(widget.post['category']),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.post['author'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E7D32),
                            ),
                          ),
                          Text(
                            widget.post['date'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Article Content
                  Text(
                    _getArticleContent(widget.post['id']),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            setState(() {
                              _isLiked = !_isLiked;
                              _likeCount += _isLiked ? 1 : -1;
                            });
                          },
                          icon: Icon(
                            _isLiked ? Icons.favorite : Icons.favorite_outline,
                            color: _isLiked ? Colors.red : Colors.grey[600],
                          ),
                          label: Text(
                            '${_likeCount} Likes',
                            style: TextStyle(
                              color: _isLiked ? Colors.red : Colors.grey[600],
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // TODO: Implement comment functionality
                          },
                          icon: Icon(
                            Icons.comment_outlined,
                            color: Colors.grey[600],
                          ),
                          label: Text(
                            '${widget.post['comments']} Comments',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'success story':
        return Colors.green;
      case 'prevention':
        return Colors.blue;
      case 'treatment':
        return Colors.orange;
      case 'organic':
        return Colors.brown;
      case 'education':
        return Colors.purple;
      case 'garden design':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  String _getArticleContent(String postId) {
    switch (postId) {
      case '1':
        return '''It all started with a few small, dark spots on the lower leaves of my tomato plants. At first, I thought it was just normal aging, but as the days passed, the spots grew larger and began to spread to other leaves. That's when I realized I was dealing with early blight.

Early blight, caused by the fungus Alternaria solani, is one of the most common diseases affecting tomato plants. The symptoms include dark, concentric rings on leaves, stems, and fruit. If left untreated, it can severely reduce your harvest.

Here's how I successfully treated my plants:

1. **Immediate Action**: I removed all infected leaves immediately to prevent the spread of spores. This is crucial in the early stages.

2. **Natural Treatment**: I created a homemade fungicide using baking soda (1 tablespoon per gallon of water) and sprayed it on the remaining healthy leaves every 7-10 days.

3. **Improving Air Circulation**: I pruned some of the lower branches to improve air flow around the plants, which helps reduce humidity.

4. **Mulching**: I added a thick layer of straw mulch around the base of the plants to prevent soil-borne spores from splashing onto the leaves.

5. **Watering Technique**: I switched to watering at the base of the plants instead of overhead watering, which keeps the leaves dry.

The results were remarkable. Within two weeks, the spread of the disease stopped, and my plants began to recover. I was able to harvest a full crop of healthy tomatoes that season.

The key lesson I learned is that early detection and immediate action are crucial when dealing with plant diseases. Don't wait to see if the problem resolves itself - act quickly and consistently.''';

      case '2':
        return '''Powdery mildew is a common fungal disease that can affect a wide variety of plants, from roses to cucumbers. It appears as a white, powdery coating on leaves, stems, and sometimes flowers. While it rarely kills plants, it can significantly reduce their vigor and yield.

**Early Warning Signs:**
- White or grayish powdery spots on leaves
- Leaves may become distorted or stunted
- Premature leaf drop
- Reduced flowering and fruiting

**Prevention Strategies:**

1. **Plant Selection**: Choose disease-resistant varieties whenever possible. Many seed catalogs now indicate which varieties are resistant to powdery mildew.

2. **Proper Spacing**: Give your plants plenty of room to breathe. Crowded plants create humid conditions that favor fungal growth.

3. **Morning Watering**: Water your plants in the morning so the leaves have time to dry before evening. Avoid overhead watering when possible.

4. **Good Air Circulation**: Prune plants regularly to maintain good air flow. This is especially important for dense plants like roses.

5. **Healthy Soil**: Maintain well-draining soil with good organic matter content. Healthy plants are more resistant to disease.

**Natural Treatment Options:**

- **Baking Soda Spray**: Mix 1 tablespoon baking soda, 1/2 teaspoon liquid soap, and 1 gallon of water. Spray weekly.
- **Milk Spray**: Mix 1 part milk with 9 parts water and spray every 7-10 days.
- **Neem Oil**: Apply neem oil according to package directions for a natural fungicide.

Remember, prevention is always better than cure. By implementing these strategies early in the growing season, you can often avoid powdery mildew altogether.''';

      case '3':
        return '''Late blight is one of the most devastating diseases that can affect potatoes and tomatoes. Caused by the water mold Phytophthora infestans, it can destroy entire crops in just a few days under the right conditions.

**My Experience:**
Last year, I lost my entire potato crop to late blight. The disease appeared suddenly after a period of cool, wet weather. Within a week, my healthy-looking plants were completely destroyed. This year, I'm determined to prevent it from happening again.

**Identification:**
- Dark, water-soaked lesions on leaves
- White, fuzzy growth on the undersides of leaves in humid conditions
- Rapid spread throughout the plant
- Brown, mushy spots on tubers

**Treatment and Prevention:**

1. **Immediate Removal**: If you spot late blight, remove infected plants immediately and dispose of them (don't compost).

2. **Fungicide Application**: Apply copper-based fungicides preventively, especially during cool, wet weather.

3. **Crop Rotation**: Never plant potatoes or tomatoes in the same spot for at least 3 years.

4. **Proper Spacing**: Space plants widely to improve air circulation and reduce humidity.

5. **Hilling**: For potatoes, hill the soil around plants to protect tubers from spores.

6. **Weather Monitoring**: Watch weather forecasts and apply preventive treatments before wet periods.

**This Year's Strategy:**
I'm using resistant varieties, applying preventive fungicides, and monitoring weather conditions closely. I've also installed drip irrigation to keep foliage dry and improved soil drainage in my garden.

The key is to be proactive rather than reactive. Late blight moves fast, so prevention is your best defense.''';

      case '4':
        return '''As an organic gardener, I've spent years developing natural solutions for common plant diseases. Here are my most effective organic treatments that have worked consistently in my garden.

**Baking Soda Spray**
This is my go-to treatment for fungal diseases. Mix 1 tablespoon baking soda, 1/2 teaspoon liquid soap, and 1 gallon of water. Spray every 7-10 days. It works by changing the pH on the leaf surface, making it inhospitable to fungi.

**Neem Oil**
Extracted from the neem tree, this oil is a powerful natural fungicide and insecticide. Mix according to package directions and apply in the evening to avoid harming beneficial insects. It's particularly effective against powdery mildew and rust.

**Compost Tea**
A well-brewed compost tea can boost plant immunity and help prevent diseases. I brew mine for 24-48 hours using good quality compost and apply it as a foliar spray or soil drench.

**Copper Fungicide**
While not completely organic, copper is allowed in organic gardening and is highly effective against many fungal diseases. Use sparingly as it can accumulate in soil.

**Beneficial Insects**
Encourage beneficial insects like ladybugs and lacewings that prey on disease-carrying pests. Plant flowers like marigolds and alyssum to attract them.

**Crop Rotation**
This is perhaps the most important organic practice. Rotate crops to prevent disease buildup in soil. I follow a 4-year rotation cycle.

**Healthy Soil**
Focus on building healthy soil with plenty of organic matter. Healthy plants are naturally more resistant to diseases. I add compost regularly and use cover crops to improve soil health.

**Plant Diversity**
Mix different types of plants together. Monocultures are more susceptible to disease outbreaks. I interplant herbs and flowers with my vegetables.

Remember, organic gardening is about prevention and working with nature, not against it. These methods may take longer to show results than chemical treatments, but they're sustainable and safe for your family and the environment.''';

      case '5':
        return '''Early detection of plant diseases can mean the difference between a successful harvest and a complete crop failure. After years of gardening, I've learned that the key to successful disease management is recognizing problems before they become severe.

**Why Early Detection Matters:**
- Diseases spread exponentially - what starts as a few spots can quickly become a full-blown epidemic
- Early treatment is more effective and requires fewer resources
- You can often save infected plants if caught early enough
- Prevention is always easier than cure

**What to Look For:**

**Visual Symptoms:**
- Discolored spots or lesions on leaves
- Wilting or drooping that doesn't improve with watering
- Stunted growth compared to healthy plants
- Unusual patterns or markings on leaves, stems, or fruit

**Behavioral Changes:**
- Plants that don't respond to normal care
- Premature leaf drop
- Reduced flowering or fruiting
- General decline in plant vigor

**My Daily Inspection Routine:**
1. **Morning Walk**: I spend 10-15 minutes each morning walking through my garden
2. **Check Under Leaves**: Many diseases start on the undersides of leaves
3. **Look for Patterns**: Diseases often follow specific patterns - check if multiple plants are affected
4. **Document Changes**: Take photos to track disease progression
5. **Act Immediately**: Don't wait to see if problems resolve themselves

**Tools for Early Detection:**
- Magnifying glass for close inspection
- Camera for documentation
- Garden journal for tracking patterns
- Knowledge of common diseases in your area

**When to Act:**
If you notice any unusual symptoms, act immediately. Remove affected plant parts, apply appropriate treatments, and monitor closely. The sooner you act, the better your chances of success.

Remember, it's better to be overly cautious than to lose your entire crop. When in doubt, research the symptoms or consult with local gardening experts.''';

      case '6':
        return '''After years of dealing with various plant diseases, I decided to take a systematic approach to garden design that would minimize disease risk from the start. The results have been remarkable - I've seen a 70% reduction in disease problems.

**Planning for Disease Prevention:**

**1. Site Selection and Preparation**
- Choose a site with good air circulation
- Ensure proper drainage to prevent waterlogged soil
- Test soil and amend as needed before planting
- Remove any diseased plant debris from previous seasons

**2. Plant Selection Strategy**
- Choose disease-resistant varieties whenever possible
- Select plants suited to your climate and growing conditions
- Avoid plants known to be disease-prone in your area
- Include a mix of annuals and perennials for diversity

**3. Garden Layout Design**
- Space plants appropriately for good air circulation
- Group plants with similar water needs together
- Create pathways for easy access and inspection
- Plan for crop rotation from the beginning

**4. Companion Planting**
- Plant disease-resistant varieties near susceptible ones
- Include aromatic herbs that may repel pests
- Use trap crops to divert pests from main crops
- Plant flowers to attract beneficial insects

**5. Water Management**
- Install drip irrigation to keep foliage dry
- Water in the morning to allow leaves to dry
- Group plants by water needs
- Plan drainage for excess water

**6. Maintenance Access**
- Design wide enough paths for easy maintenance
- Plan for easy access to all plants
- Consider mature plant sizes when spacing
- Include areas for composting and tool storage

**My Current Garden Layout:**
I've divided my garden into four main sections for crop rotation. Each section has raised beds with good drainage and wide paths between them. I've planted disease-resistant varieties and included plenty of beneficial flowers and herbs.

**Results:**
- Significantly fewer disease outbreaks
- Easier maintenance and inspection
- Better yields due to healthier plants
- More enjoyable gardening experience

The key is to think like a plant pathologist when designing your garden. Consider how diseases spread and what conditions favor them, then design your garden to minimize those conditions.''';

      default:
        return 'Article content not available.';
    }
  }
}
