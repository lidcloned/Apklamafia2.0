import 'package:flutter/material.dart';
import '../utils/theme_constants.dart';
import '../providers/user_provider.dart';
import 'package:provider/provider.dart';

class IdentidadeScreen extends StatelessWidget {
  const IdentidadeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Identidade'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cartão de perfil
            Card(
              color: ThemeConstants.surfaceColor,
              elevation: ThemeConstants.elevationMedium,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Foto de perfil
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: ThemeConstants.primaryColor,
                      backgroundImage: user?.profileImageUrl.isNotEmpty == true
                          ? NetworkImage(user!.profileImageUrl)
                          : null,
                      child: user?.profileImageUrl.isEmpty == true
                          ? const Icon(Icons.person, size: 60, color: Colors.white)
                          : null,
                    ),
                    const SizedBox(height: 16),
                    
                    // Nome do usuário
                    Text(
                      user?.username ?? 'Membro',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // ID do jogador
                    Text(
                      'ID: ${user?.gameName ?? 'N/A'}',
                      style: TextStyle(
                        color: ThemeConstants.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Cargo sinistro
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: ThemeConstants.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        user?.cargo ?? 'Membro Novo',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Descrição do cargo
                    Text(
                      user?.getCargoDescricao() ?? 'Membro da Federação',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: ThemeConstants.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Detalhes do perfil
            Text(
              'Detalhes do Perfil',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ThemeConstants.textColor,
              ),
            ),
            const SizedBox(height: 16),
            
            // Lista de detalhes
            Card(
              color: ThemeConstants.surfaceColor,
              elevation: ThemeConstants.elevationMedium,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildDetailRow('Especialidade', user?.especialidade ?? 'Não definida'),
                    const Divider(),
                    _buildDetailRow('Nível de Acesso', user?.getNivelAcessoDescricao() ?? 'Acesso Limitado'),
                    const Divider(),
                    _buildDetailRow('Data de Ingresso', _formatDate(user?.joinDate ?? '')),
                    const Divider(),
                    _buildDetailRow('Horas Registradas', '${user?.hoursPlayed ?? 0}h'),
                    const Divider(),
                    _buildDetailRow('Pontos', '${user?.points ?? 0}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Histórico de atividades
            Text(
              'Histórico de Atividades',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ThemeConstants.textColor,
              ),
            ),
            const SizedBox(height: 16),
            
            // Lista de atividades (simulada)
            Card(
              color: ThemeConstants.surfaceColor,
              elevation: ThemeConstants.elevationMedium,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(
                      _getActivityIcon(index),
                      color: ThemeConstants.accentColor,
                    ),
                    title: Text(_getActivityTitle(index)),
                    subtitle: Text(_getActivityDate(index)),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: ThemeConstants.textSecondaryColor,
                    ),
                    onTap: () {
                      // Abrir detalhes da atividade
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: ThemeConstants.textSecondaryColor,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  
  String _formatDate(String isoDate) {
    if (isoDate.isEmpty) return 'N/A';
    try {
      final date = DateTime.parse(isoDate);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return 'N/A';
    }
  }
  
  IconData _getActivityIcon(int index) {
    final icons = [
      Icons.login,
      Icons.access_time,
      Icons.assignment,
      Icons.photo_camera,
      Icons.map,
    ];
    return icons[index % icons.length];
  }
  
  String _getActivityTitle(int index) {
    final activities = [
      'Login no sistema',
      'Ponto registrado',
      'Relatório enviado',
      'Foto enviada',
      'Mapa tático acessado',
    ];
    return activities[index % activities.length];
  }
  
  String _getActivityDate(int index) {
    final now = DateTime.now();
    final date = now.subtract(Duration(days: index, hours: index * 2));
    return '${date.day}/${date.month}/${date.year} às ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
