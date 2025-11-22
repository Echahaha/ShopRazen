import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewAnimatedState createState() => _SplashViewAnimatedState();
}

class _SplashViewAnimatedState extends State<SplashView>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _loadingController;
  
  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;
  late Animation<double> _loadingAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize controllers
    _logoController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _textController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    
    _loadingController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    
    // Initialize animations
    _logoAnimation = CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    );
    
    _textAnimation = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOut,
    );
    
    _loadingAnimation = CurvedAnimation(
      parent: _loadingController,
      curve: Curves.easeIn,
    );
    
    // Start animations sequence
    _startAnimations();
    
    // Initialize controller
    Get.put(SplashController());
  }
  
  void _startAnimations() async {
    await Future.delayed(Duration(milliseconds: 300));
    _logoController.forward();
    
    await Future.delayed(Duration(milliseconds: 500));
    _textController.forward();
    
    await Future.delayed(Duration(milliseconds: 300));
    _loadingController.forward();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2196F3),
              Color(0xFF1976D2),
              Color(0xFF0D47A1),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 2),
            
            // Animated Logo
            ScaleTransition(
              scale: _logoAnimation,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 25,
                      offset: Offset(0, 15),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.shopping_cart_rounded,
                  size: 80,
                  color: Color(0xFF1976D2),
                ),
              ),
            ),
            
            SizedBox(height: 40),
            
            // Animated Text
            FadeTransition(
              opacity: _textAnimation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(_textAnimation),
                child: Column(
                  children: [
                    Text(
                      'Shop Razen',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Belanja Mudah, Hidup Bahagia',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            Spacer(flex: 2),
            
            // Animated Loading
            FadeTransition(
              opacity: _loadingAnimation,
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      backgroundColor: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Sedang memuat aplikasi...',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}