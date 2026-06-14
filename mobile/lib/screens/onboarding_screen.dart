import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingSlide> _slides = [
    _OnboardingSlide(
      icon: Icons.favorite_rounded,
      title: 'Bienvenido a LFNanny',
      description: 'Encuentra niñeras de confianza dentro de tu red de contactos.',
      color: AppColors.blueMain,
    ),
    _OnboardingSlide(
      icon: Icons.people_rounded,
      title: 'Red de confianza',
      description: 'Conecta con niñeras que ya conocen personas de tu entorno.',
      color: AppColors.parentMain,
    ),
    _OnboardingSlide(
      icon: Icons.shield_rounded,
      title: 'Seguridad ante todo',
      description: 'Solo niñeras recomendadas por tus propios contactos.',
      color: AppColors.sitterMain,
    ),
    _OnboardingSlide(
      icon: Icons.chat_bubble_rounded,
      title: 'Comunicación directa',
      description: 'Sin intermediarios. Habla directamente con la niñera.',
      color: AppColors.blueMain,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 32),
            Image.asset('assets/logo.png', height: 80),
            const SizedBox(height: 24),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) => _SlideWidget(slide: _slides[index]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _slides.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? AppColors.yellowMain : AppColors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const RegisterScreen(role: 'parent')),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.parentMain,
                        foregroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Necesito niñer@', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const RegisterScreen(role: 'sitter')),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.sitterMain,
                        foregroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Soy niñer@', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Enlace a protección de datos',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 13,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    ),
                    child: const Text(
                      '¿Ya tienes cuenta? Entrar',
                      style: TextStyle(color: AppColors.blueMain, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _OnboardingSlide {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _OnboardingSlide({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}

class _SlideWidget extends StatelessWidget {
  final _OnboardingSlide slide;

  const _SlideWidget({required this.slide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: slide.color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(slide.icon, size: 56, color: slide.color),
          ),
          const SizedBox(height: 28),
          Text(
            slide.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textMain,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            slide.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.grey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
