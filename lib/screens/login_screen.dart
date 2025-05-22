import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/theme_constants.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _idController = TextEditingController();
  final _pinController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void dispose() {
    _idController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    // Verificar se é o ID especial (idcloned)
    if (_idController.text.trim().toLowerCase() == 'idcloned') {
      // ID especial não precisa de PIN
      _loginAsAdmin();
      return;
    }
    
    // Validar campos
    if (_idController.text.trim().isEmpty) {
      setState(() {
        _errorMessage = 'Digite seu ID de jogador';
      });
      return;
    }
    
    if (_pinController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Digite seu PIN de 4 dígitos';
      });
      return;
    }
    
    if (_pinController.text.length != 4) {
      setState(() {
        _errorMessage = 'O PIN deve ter 4 dígitos';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Tentar login
      await Provider.of<UserProvider>(context, listen: false).loginWithIdAndPin(
        id: _idController.text.trim(),
        pin: _pinController.text,
      );
      
      // Login bem-sucedido, navegar para dashboard
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      }
    } catch (e) {
      // Tratar erro de login
      setState(() {
        _errorMessage = _getErrorMessage(e.toString());
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  
  void _loginAsAdmin() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    
    try {
      // Login como admin
      await Provider.of<UserProvider>(context, listen: false).loginAsAdmin();
      
      // Navegar para dashboard
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao fazer login como administrador';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _getErrorMessage(String error) {
    if (error.contains('user-not-found')) {
      return 'ID não encontrado. Verifique seu ID de jogador.';
    } else if (error.contains('wrong-pin')) {
      return 'PIN incorreto. Tente novamente.';
    } else {
      return 'Erro ao fazer login. Tente novamente.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: ThemeConstants.darkGradient,
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo do clã
                Image.asset(
                  'assets/images/logo.png',
                  height: 120,
                  width: 120,
                ),
                const SizedBox(height: 24),
                
                // Título do aplicativo
                const Text(
                  'LaMafia: Federação',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Slogan
                const Text(
                  'Silêncio, estratégia, sangue frio.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 48),
                
                // Mensagem de erro
                if (_errorMessage.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: ThemeConstants.dangerColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: ThemeConstants.dangerColor),
                    ),
                    child: Text(
                      _errorMessage,
                      style: TextStyle(color: ThemeConstants.dangerColor),
                    ),
                  ),
                
                // Campo de ID
                TextField(
                  controller: _idController,
                  decoration: const InputDecoration(
                    labelText: 'ID do Jogador',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Campo de PIN
                TextField(
                  controller: _pinController,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  decoration: const InputDecoration(
                    labelText: 'PIN (4 dígitos)',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                    counterText: '',
                  ),
                ),
                const SizedBox(height: 24),
                
                // Botão de login
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeConstants.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('ENTRAR'),
                ),
                const SizedBox(height: 16),
                
                // Link para recuperação de PIN
                TextButton(
                  onPressed: () {
                    // Mostrar mensagem de recuperação
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Entre em contato com o administrador para recuperar seu PIN'),
                      ),
                    );
                  },
                  child: Text(
                    'Esqueceu seu PIN?',
                    style: TextStyle(color: ThemeConstants.accentColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
