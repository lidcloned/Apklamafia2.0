import 'package:flutter/material.dart';
import '../utils/theme_constants.dart';
import '../providers/user_provider.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  bool _modoAlertaAtivo = false;
  
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    
    // Verificar se é o idcloned
    if (!userProvider.isIdCloned()) {
      // Redirecionar para tela principal se não for admin
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Acesso negado. Apenas o administrador pode acessar este painel.'),
            backgroundColor: Colors.red,
          ),
        );
      });
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel Administrativo'),
        backgroundColor: ThemeConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cartão de boas-vindas ao admin
            Card(
              color: ThemeConstants.surfaceColor,
              elevation: ThemeConstants.elevationMedium,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: ThemeConstants.primaryColor,
                      radius: 30,
                      child: const Icon(
                        Icons.admin_panel_settings,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Bem-vindo, Administrador',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Acesso total ao sistema',
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
            ),
            const SizedBox(height: 24),
            
            // Modo Alerta
            Card(
              color: _modoAlertaAtivo ? ThemeConstants.dangerColor.withOpacity(0.2) : ThemeConstants.surfaceColor,
              elevation: ThemeConstants.elevationMedium,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.warning,
                          color: _modoAlertaAtivo ? ThemeConstants.dangerColor : ThemeConstants.textSecondaryColor,
                          size: 24,
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'Modo Alerta',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'O Modo Alerta notifica todos os membros sobre situações críticas que requerem atenção imediata.',
                      style: TextStyle(
                        color: ThemeConstants.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: Text(
                        _modoAlertaAtivo ? 'ALERTA ATIVADO' : 'ALERTA DESATIVADO',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _modoAlertaAtivo ? ThemeConstants.dangerColor : ThemeConstants.textSecondaryColor,
                        ),
                      ),
                      value: _modoAlertaAtivo,
                      activeColor: ThemeConstants.dangerColor,
                      onChanged: (value) {
                        setState(() {
                          _modoAlertaAtivo = value;
                        });
                        
                        // Mostrar confirmação
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(_modoAlertaAtivo ? 'Modo Alerta ativado!' : 'Modo Alerta desativado'),
                            backgroundColor: _modoAlertaAtivo ? ThemeConstants.dangerColor : Colors.green,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Módulos administrativos
            Text(
              'Gerenciamento',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ThemeConstants.textColor,
              ),
            ),
            const SizedBox(height: 16),
            
            // Grid de módulos admin
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildAdminModuleCard(
                  'Membros',
                  Icons.people,
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Gerenciamento de membros em desenvolvimento')),
                    );
                  },
                ),
                _buildAdminModuleCard(
                  'Cargos',
                  Icons.badge,
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Gerenciamento de cargos em desenvolvimento')),
                    );
                  },
                ),
                _buildAdminModuleCard(
                  'Mapas',
                  Icons.map,
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Gerenciamento de mapas em desenvolvimento')),
                    );
                  },
                ),
                _buildAdminModuleCard(
                  'Relatórios',
                  Icons.assessment,
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Gerenciamento de relatórios em desenvolvimento')),
                    );
                  },
                ),
                _buildAdminModuleCard(
                  'Comunicados',
                  Icons.announcement,
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Envio de comunicados em desenvolvimento')),
                    );
                  },
                ),
                _buildAdminModuleCard(
                  'Backup',
                  Icons.backup,
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Sistema de backup em desenvolvimento')),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Estatísticas
            Text(
              'Estatísticas do Clã',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ThemeConstants.textColor,
              ),
            ),
            const SizedBox(height: 16),
            
            // Cartões de estatísticas
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('Membros Ativos', '24', Icons.people, Colors.blue),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard('Missões', '12', Icons.assignment, Colors.orange),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('Relatórios', '47', Icons.description, Colors.green),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard('Fotos', '86', Icons.photo, Colors.purple),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Ações de emergência
            Text(
              'Ações de Emergência',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ThemeConstants.textColor,
              ),
            ),
            const SizedBox(height: 16),
            
            // Botões de emergência
            Card(
              color: ThemeConstants.surfaceColor,
              elevation: ThemeConstants.elevationMedium,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.delete_forever,
                        color: ThemeConstants.dangerColor,
                      ),
                      title: const Text('Limpar Todos os Dados'),
                      subtitle: const Text('Apaga todos os dados do sistema. Esta ação não pode ser desfeita.'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        _showResetConfirmation();
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.lock_reset,
                        color: ThemeConstants.warningColor,
                      ),
                      title: const Text('Resetar Permissões'),
                      subtitle: const Text('Redefine todas as permissões para o padrão.'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Reset de permissões em desenvolvimento')),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.security,
                        color: ThemeConstants.accentColor,
                      ),
                      title: const Text('Modo Segurança'),
                      subtitle: const Text('Ativa proteções adicionais e restringe o acesso ao sistema.'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Modo segurança em desenvolvimento')),
                        );
                      },
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
  
  Widget _buildAdminModuleCard(String title, IconData icon, VoidCallback onTap) {
    return Card(
      color: ThemeConstants.surfaceColor,
      elevation: ThemeConstants.elevationMedium,
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
                size: 40,
                color: ThemeConstants.accentColor,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      color: ThemeConstants.surfaceColor,
      elevation: ThemeConstants.elevationMedium,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              icon,
              size: 30,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                color: ThemeConstants.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  void _showResetConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Reset'),
        content: const Text(
          'Tem certeza que deseja limpar todos os dados do sistema? Esta ação não pode ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: ThemeConstants.dangerColor,
            ),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Reset de dados em desenvolvimento')),
              );
            },
            child: const Text('Confirmar Reset'),
          ),
        ],
      ),
    );
  }
}
