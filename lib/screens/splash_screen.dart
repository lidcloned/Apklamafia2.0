import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'login_screen.dart';
import '../utils/theme_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _logoVisible = false;
  bool _sloganVisible = false;

  @override
  void initState() {
    super.initState();
    
    // Configurar animação
    _animationController = AnimationController(
      vsync: this,
      duration: ThemeConstants.animationDurationLong,
    );
    
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    
    // Iniciar sequência de animação
    _startSplashSequence();
  }

  Future<void> _startSplashSequence() async {
    // Reproduzir som de rodas (simulado)
    await _audioPlayer.play(AssetSource('audio/sounds/wheels.mp3'));
    
    // Mostrar logo com fade-in
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _logoVisible = true;
    });
    _animationController.forward();
    
    // Reproduzir som de tiros após o som de rodas
    await Future.delayed(const Duration(milliseconds: 1500));
    await _audioPlayer.play(AssetSource('audio/sounds/gunshots.mp3'));
    
    // Mostrar slogan
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      _sloganVisible = true;
    });
    
    // Reproduzir música ambiente
    await Future.delayed(const Duration(milliseconds: 1000));
    await _audioPlayer.play(AssetSource('audio/sounds/ambient.mp3'));
    
    // Navegar para a próxima tela após a animação completa
    await Future.delayed(const Duration(milliseconds: 2000));
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: ThemeConstants.darkGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo com animação de fade-in
              AnimatedOpacity(
                opacity: _logoVisible ? 1.0 : 0.0,
                duration: ThemeConstants.animationDurationMedium,
                child: FadeTransition(
                  opacity: _fadeInAnimation,
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              
              // Slogan com animação de fade-in
              AnimatedOpacity(
                opacity: _sloganVisible ? 1.0 : 0.0,
                duration: ThemeConstants.animationDurationMedium,
                child: Text(
                  'Silêncio, estratégia, sangue frio.\nBem-vindo à LaMafia: Federação.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
