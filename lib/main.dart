import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  runApp(HydroponicApp());
}

class HydroponicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Hydroponic Monitor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
          secondary: Colors.teal,
        ),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 20),
          bodyMedium: TextStyle(fontSize: 18),
        ),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/wallpaper/welcome.png',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Logo at the top
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Image.asset(
                    'assets/logo/logo_1.png',
                    height: 120,
                    width: 120,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        SlideTransition(
                          position: _slideAnimation,
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: Column(
                              children: [
                                Text(
                                  'Smart Hydroponic',
                                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10.0,
                                        color: Colors.black.withOpacity(0.5),
                                        offset: const Offset(5.0, 5.0),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Monitor your plants with precision',
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.white70,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: Shimmer.fromColors(
                            baseColor: Colors.teal.withOpacity(0.7),
                            highlightColor: Colors.tealAccent.withOpacity(0.7),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const PlantListScreen()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 8,
                                shadowColor: Colors.tealAccent.withOpacity(0.5),
                              ),
                              child: const Text(
                                'Get Started',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 48),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PlantListScreen extends StatefulWidget {
  const PlantListScreen({Key? key}) : super(key: key);

  @override
  _PlantListScreenState createState() => _PlantListScreenState();
}

class _PlantListScreenState extends State<PlantListScreen> {
  final List<Plant> plants = [
    Plant(
      name: 'Basil',
      image: 'assets/englishe/basil.png',
      phLevel: 6.0,
      idealPhRange: '5.5 - 6.5',
      temperature: 23.5,
      humidity: 65,
    ),
    Plant(
      name: 'Lettuce',
      image: 'assets/englishe/lettuce.png',
      phLevel: 6.2,
      idealPhRange: '6.0 - 7.0',
      temperature: 22.0,
      humidity: 70,
    ),
    Plant(
      name: 'Tomato',
      image: 'assets/englishe/tomato.png',
      phLevel: 6.3,
      idealPhRange: '5.5 - 6.8',
      temperature: 24.0,
      humidity: 75,
    ),
    Plant(
      name: 'Cucumber',
      image: 'assets/englishe/cucumber.png',
      phLevel: 5.8,
      idealPhRange: '5.5 - 6.5',
      temperature: 23.0,
      humidity: 70,
    ),
    Plant(
      name: 'Bell Pepper',
      image: 'assets/englishe/bell_pepper.png',
      phLevel: 6.4,
      idealPhRange: '5.5 - 6.8',
      temperature: 25.0,
      humidity: 65,
    ),
    Plant(
      name: 'Strawberry',
      image: 'assets/englishe/strawberry.png',
      phLevel: 5.9,
      idealPhRange: '5.5 - 6.8',
      temperature: 21.0,
      humidity: 75,
    ),
    Plant(
      name: 'Mint',
      image: 'assets/englishe/mint.png',
      phLevel: 6.1,
      idealPhRange: '5.5 - 6.5',
      temperature: 22.5,
      humidity: 65,
    ),
    Plant(
      name: 'Arugula',
      image: 'assets/englishe/arugula.png',
      phLevel: 6.0,
      idealPhRange: '6.0 - 7.0',
      temperature: 20.0,
      humidity: 60,
    ),
    Plant(
      name: 'Eggplant',
      image: 'assets/englishe/eggplant.png',
      phLevel: 5.8,
      idealPhRange: '5.5 - 6.5',
      temperature: 25.0,
      humidity: 70,
    ),
    Plant(
      name: 'Lemon',
      image: 'assets/englishe/lemon.png',
      phLevel: 6.5,
      idealPhRange: '6.0 - 7.0',
      temperature: 23.0,
      humidity: 65,
    ),
    Plant(
      name: 'Okra',
      image: 'assets/englishe/okra.png',
      phLevel: 6.2,
      idealPhRange: '6.0 - 7.0',
      temperature: 26.0,
      humidity: 70,
    ),
    Plant(
      name: 'Parsley',
      image: 'assets/englishe/parsley.png',
      phLevel: 6.0,
      idealPhRange: '5.5 - 6.7',
      temperature: 21.0,
      humidity: 65,
    ),
    Plant(
      name: 'Sage',
      image: 'assets/englishe/sage.png',
      phLevel: 6.1,
      idealPhRange: '5.5 - 6.5',
      temperature: 22.0,
      humidity: 60,
    ),
    Plant(
      name: 'Watermelon',
      image: 'assets/englishe/watermelon.png',
      phLevel: 5.8,
      idealPhRange: '5.5 - 6.5',
      temperature: 24.0,
      humidity: 75,
    ),
    Plant(
      name: 'Zucchini',
      image: 'assets/englishe/zucchini.png',
      phLevel: 6.0,
      idealPhRange: '5.5 - 6.8',
      temperature: 23.5,
      humidity: 70,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/logo/logo_1.png',
              height: 40,
              width: 40,
            ),
            const SizedBox(width: 8),
            const Text('My Plants'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Implement add plant functionality
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: plants.length,
        itemBuilder: (context, index) {
          final plant = plants[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlantDetailScreen(plant: plant),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        plant.image,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plant.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'pH Level: ${plant.phLevel.toStringAsFixed(1)}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            'Temperature: ${plant.temperature.toStringAsFixed(1)}°C',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement quick pH measurement
        },
        child: const Icon(Icons.science),
      ),
    );
  }
}

class PlantDetailScreen extends StatelessWidget {
  final Plant plant;

  const PlantDetailScreen({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/logo/logo_1.png',
              height: 40,
              width: 40,
            ),
            const SizedBox(width: 8),
            Text(plant.name),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              plant.image,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(
                    context,
                    'Current pH Level',
                    '${plant.phLevel.toStringAsFixed(1)}',
                    Icons.science,
                    _getPhLevelColor(plant.phLevel),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    context,
                    'Ideal pH Range',
                    plant.idealPhRange,
                    Icons.check_circle,
                    Colors.green,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    context,
                    'Temperature',
                    '${plant.temperature.toStringAsFixed(1)}°C',
                    Icons.thermostat,
                    Colors.orange,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    context,
                    'Humidity',
                    '${plant.humidity}%',
                    Icons.water_drop,
                    Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
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

  Color _getPhLevelColor(double ph) {
    if (ph < 6.0) return Colors.red;
    if (ph > 7.0) return Colors.purple;
    return Colors.green;
  }
}

class Plant {
  final String name;
  final String image;
  final double phLevel;
  final String idealPhRange;
  final double temperature;
  final int humidity;

  const Plant({
    required this.name,
    required this.image,
    required this.phLevel,
    required this.idealPhRange,
    required this.temperature,
    required this.humidity,
  });
}