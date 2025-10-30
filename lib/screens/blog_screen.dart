import 'package:flutter/material.dart';
import 'blog_detail_screen.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final List<Map<String, dynamic>> _blogPosts = [
    {
      'id': '1',
      'title': 'How I Saved My Tomato Plants from Early Blight',
      'author': 'Sarah Johnson',
      'date': '2024-01-15',
      'readTime': '5 min read',
      'excerpt': 'After noticing dark spots on my tomato leaves, I discovered it was early blight. Here\'s how I treated it naturally and saved my entire crop.',
      'image': 'assets/images/blog1.jpg',
      'category': 'Success Story',
      'likes': 24,
      'comments': 8,
    },
    {
      'id': '2',
      'title': 'Preventing Powdery Mildew in Your Garden',
      'author': 'Mike Chen',
      'date': '2024-01-12',
      'readTime': '7 min read',
      'excerpt': 'Learn the early warning signs of powdery mildew and discover effective prevention strategies that have worked in my garden for years.',
      'image': 'assets/images/blog2.jpg',
      'category': 'Prevention',
      'likes': 18,
      'comments': 12,
    },
    {
      'id': '3',
      'title': 'My Battle with Late Blight: A Complete Guide',
      'author': 'Emily Rodriguez',
      'date': '2024-01-10',
      'readTime': '10 min read',
      'excerpt': 'Late blight devastated my potato crop last year. This season, I\'m sharing everything I learned about identification, treatment, and prevention.',
      'image': 'assets/images/blog3.jpg',
      'category': 'Treatment',
      'likes': 31,
      'comments': 15,
    },
    {
      'id': '4',
      'title': 'Organic Solutions for Common Plant Diseases',
      'author': 'David Thompson',
      'date': '2024-01-08',
      'readTime': '8 min read',
      'excerpt': 'Discover natural, chemical-free methods to treat plant diseases. From baking soda sprays to beneficial insects, here are my go-to solutions.',
      'image': 'assets/images/blog4.jpg',
      'category': 'Organic',
      'likes': 42,
      'comments': 19,
    },
    {
      'id': '5',
      'title': 'The Importance of Early Disease Detection',
      'author': 'Lisa Park',
      'date': '2024-01-05',
      'readTime': '6 min read',
      'excerpt': 'Why catching plant diseases early is crucial for successful treatment. Learn to spot the subtle signs before it\'s too late.',
      'image': 'assets/images/blog5.jpg',
      'category': 'Education',
      'likes': 27,
      'comments': 6,
    },
    {
      'id': '6',
      'title': 'Building a Disease-Resistant Garden',
      'author': 'Robert Wilson',
      'date': '2024-01-03',
      'readTime': '9 min read',
      'excerpt': 'How I designed my garden layout and chose plant varieties to minimize disease risk. A comprehensive approach to healthy gardening.',
      'image': 'assets/images/blog6.jpg',
      'category': 'Garden Design',
      'likes': 35,
      'comments': 11,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Stories'),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
            },
          ),
        ],
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
                    Icons.article,
                    size: 48,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Plant Stories & Tips',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Learn from fellow gardeners and share your experiences',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Blog Posts
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _blogPosts.length,
                  itemBuilder: (context, index) {
                    final post = _blogPosts[index];
                    return _buildBlogCard(post);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateBlogDialog();
        },
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showCreateBlogDialog() {
    showDialog(
      context: context,
      builder: (context) => CreateBlogDialog(
        onBlogCreated: (blogPost) {
          setState(() {
            _blogPosts.insert(0, blogPost);
          });
        },
      ),
    );
  }

  Widget _buildBlogCard(Map<String, dynamic> post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlogDetailScreen(post: post),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image placeholder
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _getCategoryColor(post['category']).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.article,
                          size: 48,
                          color: _getCategoryColor(post['category']),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          post['title'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _getCategoryColor(post['category']),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Category and Read Time
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(post['category']),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        post['category'],
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
                      post['readTime'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Title
                Text(
                  post['title'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                // Excerpt
                Text(
                  post['excerpt'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),

                // Author and Date
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: _getCategoryColor(post['category']).withOpacity(0.2),
                      child: Text(
                        post['author'][0],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _getCategoryColor(post['category']),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      post['author'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '•',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      post['date'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Likes and Comments
                Row(
                  children: [
                    Icon(
                      Icons.favorite_outline,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      post['likes'].toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.comment_outlined,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      post['comments'].toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey[400],
                    ),
                  ],
                ),
              ],
            ),
          ),
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
}

class CreateBlogDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onBlogCreated;

  const CreateBlogDialog({
    super.key,
    required this.onBlogCreated,
  });

  @override
  State<CreateBlogDialog> createState() => _CreateBlogDialogState();
}

class _CreateBlogDialogState extends State<CreateBlogDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _excerptController = TextEditingController();
  final _contentController = TextEditingController();
  String _selectedCategory = 'Success Story';
  bool _isLoading = false;

  final List<String> _categories = [
    'Success Story',
    'Prevention',
    'Treatment',
    'Organic',
    'Education',
    'Garden Design',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _excerptController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFF2E7D32),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Create New Blog Post',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),

            // Form
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          hintText: 'Enter blog post title',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Category
                      DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        decoration: const InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(),
                        ),
                        items: _categories.map((category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 16),

                      // Excerpt
                      TextFormField(
                        controller: _excerptController,
                        decoration: const InputDecoration(
                          labelText: 'Excerpt',
                          hintText: 'Brief description of your post',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 2,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an excerpt';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Content
                      TextFormField(
                        controller: _contentController,
                        decoration: const InputDecoration(
                          labelText: 'Content',
                          hintText: 'Write your blog post content here...',
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                        ),
                        maxLines: 6,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter content';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Actions
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: _isLoading ? null : () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _createBlogPost,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Create Post'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _createBlogPost() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    final now = DateTime.now();
    final blogPost = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'title': _titleController.text,
      'author': 'You', // In a real app, this would come from user data
      'date': '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}',
      'readTime': '${(_contentController.text.split(' ').length / 200).ceil()} min read',
      'excerpt': _excerptController.text,
      'image': 'assets/images/blog_placeholder.jpg',
      'category': _selectedCategory,
      'likes': 0,
      'comments': 0,
      'content': _contentController.text,
    };

    widget.onBlogCreated(blogPost);
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Blog post created successfully!'),
        backgroundColor: Color(0xFF2E7D32),
      ),
    );
  }
}
