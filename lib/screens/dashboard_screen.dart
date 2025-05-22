import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/theme_constants.dart';
import '../models/user_model.dart';
import 'identidade_screen.dart';
import 'mapa_tatico_screen.dart';
import 'relatorio_screen.dart';
import 'estrutura_screen.dart';
import 'fotos_screen.dart';
import 'admin_screen.dart';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  bool _pontoAberto = false;
  bool _modoAlertaAtivo = false;
  
  @override
  void initState() {
    super.initState();
    // Verificar status do ponto e modo alerta
    _verificarStatusPonto();
    _verificarModoAlerta();
  }
  
  void _verificarStatusPonto() {
    // Em uma implementação real, isso viria do banco de dados
    setState(() {
      _pontoAberto = false;
    });
  }
  
  void _verificarModoAlerta() {
    // Em uma implementação real, isso viria do banco de dados
    setState(() {
      _modoAlertaAtivo = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    
    // Mostrar indicador de carregamento enquanto os dados do usuário são carregados
    if (userProvider.isLoading) {
      return Scaffold(
        backgroundColor: ThemeConstants.backgroundColor,
        body: Center(
          child: CircularProgressIndicator(color: ThemeConstants.primaryColor),
        ),
      );
    }

    final user = userProvider.user;
    final bool isIdCloned = userProvider.isIdCloned();

    return Scaffold(
      appBar: AppBar(
        title: const Text('LaMafia: Federação'),
        actions: [
          // Botão de notificações
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Abrir tela de notificações
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notificações em desenvolvimento')),
              );
            },
          ),
          // Menu de opções
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'admin') {
                // Verificar se o usuário é admin ou idcloned
                bool isAdmin = await userProvider.isAdminOrOwner();
                if (isAdmin && mounted) {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AdminScreen()),
                  );
                } else {
                  // Mostrar mensagem de erro
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Você não tem permissão para acessar o painel administrativo.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              } else if (value == 'settings') {
                // Abrir configurações
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Configurações em desenvolvimento')),
                );
              } else if (value == 'logout') {
                // Fazer logout
                await userProvider.logout();
                if (mounted) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                }
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'admin',
                  child: Text('Painel Administrativo'),
                ),
                const PopupMenuItem<String>(
                  value: 'settings',
                  child: Text('Configurações'),
                ),
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Sair'),
                ),
              ];
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cartão de boas-vindas
            Card(
              color: ThemeConstants.surfaceColor,
              elevation: ThemeConstants.elevationMedium,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bem-vindo, ${user?.username ?? 'Membro'}!',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Cargo: ${user?.cargo ?? 'Membro Novo'}',
                      style: TextStyle(
                        color: ThemeConstants.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Status do ponto
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _pontoAberto ? 'PONTO ABERTO' : 'PONTO FECHADO',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _pontoAberto ? ThemeConstants.successColor : ThemeConstants.dangerColor,
                              ),
                            ),
                            Text(
                              _pontoAberto ? 'Sessão em andamento' : 'Inicie sua sessão',
                              style: TextStyle(
                                fontSize: 12,
                                color: ThemeConstants.textSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: _togglePonto,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _pontoAberto ? ThemeConstants.dangerColor : ThemeConstants.successColor,
                            foregroundColor: Colors.white,
                          ),
                          child: Text(_pontoAberto ? 'FECHAR PONTO' : 'ABRIR PONTO'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Alerta (se ativo)
            if (_modoAlertaAtivo)
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: ThemeConstants.dangerColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: ThemeConstants.dangerColor),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning, color: ThemeConstants.dangerColor),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'MODO ALERTA ATIVADO',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Mantenha-se atento às instruções da liderança.',
                            style: TextStyle(
                              color: ThemeConstants.textSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            
            // Título da seção de módulos
            Text(
              'Módulos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ThemeConstants.textColor,
              ),
            ),
            const SizedBox(height: 16),
            
            // Grid de módulos
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                // Identidade
                _buildModuleCard(
                  icon: Icons.person,
                  title: 'Identidade',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const IdentidadeScreen()),
                  ),
                ),
                
                // Mapa Tático
                _buildModuleCard(
                  icon: Icons.map,
                  title: 'Mapa Tático',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MapaTaticoScreen()),
                  ),
                ),
                
                // Relatório
                _buildModuleCard(
                  icon: Icons.assignment,
                  title: 'Relatório',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RelatorioScreen()),
                  ),
                ),
                
                // Estrutura
                _buildModuleCard(
                  icon: Icons.account_tree,
                  title: 'Estrutura',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EstruturaScreen()),
                  ),
                ),
                
                // Fotos
                _buildModuleCard(
                  icon: Icons.photo_camera,
                  title: 'Fotos',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FotosScreen()),
                  ),
                ),
                
                // Admin (apenas para idcloned)
                if (isIdCloned)
                  _buildModuleCard(
                    icon: Icons.admin_panel_settings,
                    title: 'Admin',
                    color: ThemeConstants.primaryColor,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AdminScreen()),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildModuleCard({
    required IconData icon,
    required String title,
    Color? color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: ThemeConstants.elevationMedium,
      color: color ?? ThemeConstants.surfaceColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: ThemeConstants.accentColor,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ThemeConstants.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _togglePonto() {
    setState(() {
      _pontoAberto = !_pontoAberto;
    });
    
    // Em uma implementação real, isso seria salvo no banco de dados
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_pontoAberto ? 'Ponto aberto com sucesso' : 'Ponto fechado com sucesso'),
        backgroundColor: _pontoAberto ? ThemeConstants.successColor : ThemeConstants.primaryColor,
      ),
    );
  }
}
