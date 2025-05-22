import 'package:flutter/material.dart';
import '../utils/theme_constants.dart';
import '../providers/user_provider.dart';
import 'package:provider/provider.dart';

class EstruturaScreen extends StatelessWidget {
  const EstruturaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estrutura do Clã'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bandeira do clã
            Card(
              color: ThemeConstants.surfaceColor,
              elevation: ThemeConstants.elevationMedium,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/bandeira.jpg',
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'LaMafia: Federação',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Silêncio, estratégia, sangue frio.',
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
            
            // Título da seção de cargos
            Text(
              'Cargos Sinistros',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ThemeConstants.textColor,
              ),
            ),
            const SizedBox(height: 16),
            
            // Lista de cargos
            Card(
              color: ThemeConstants.surfaceColor,
              elevation: ThemeConstants.elevationMedium,
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildCargoItem(
                    'OLHO CORTANTE',
                    'Vigilância total',
                    'Responsável por monitorar todas as atividades do clã e identificar possíveis ameaças internas ou externas.',
                    Icons.visibility,
                    2,
                  ),
                  const Divider(),
                  _buildCargoItem(
                    'VOZ SOMBRIA',
                    'Intermediador',
                    'Porta-voz oficial do clã, responsável pela comunicação entre liderança e membros.',
                    Icons.record_voice_over,
                    2,
                  ),
                  const Divider(),
                  _buildCargoItem(
                    'FANTASMA DA BASE',
                    'Executor de contra-infiltração',
                    'Especialista em identificar e neutralizar tentativas de infiltração no clã.',
                    Icons.person_off,
                    1,
                  ),
                  const Divider(),
                  _buildCargoItem(
                    'DÍZIMO NEGRO',
                    'Gerente de recursos',
                    'Administrador dos recursos e suprimentos do clã, garantindo distribuição eficiente.',
                    Icons.inventory,
                    1,
                  ),
                  const Divider(),
                  _buildCargoItem(
                    'PALMA DO JULGAMENTO',
                    'Responsável por testes/relatórios',
                    'Avalia o desempenho dos membros através de testes e análise de relatórios.',
                    Icons.assessment,
                    1,
                  ),
                  const Divider(),
                  _buildCargoItem(
                    'VÉU DE BRASA',
                    'Líder de infiltração/rastreamento',
                    'Coordena operações de infiltração e rastreamento em territórios hostis.',
                    Icons.location_searching,
                    1,
                  ),
                  const Divider(),
                  _buildCargoItem(
                    'GRITO MUDO',
                    'Guardião dos segredos',
                    'Protege informações confidenciais do clã e gerencia protocolos de segurança.',
                    Icons.security,
                    2,
                  ),
                  const Divider(),
                  _buildCargoItem(
                    'VÁCUO AZUL',
                    'Controle de mapas/rotas',
                    'Especialista em cartografia e planejamento de rotas estratégicas.',
                    Icons.map,
                    1,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Níveis de acesso
            Text(
              'Níveis de Acesso',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ThemeConstants.textColor,
              ),
            ),
            const SizedBox(height: 16),
            
            // Lista de níveis
            Card(
              color: ThemeConstants.surfaceColor,
              elevation: ThemeConstants.elevationMedium,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildNivelAcesso(
                      'Acesso Total',
                      'Permissão completa a todos os módulos e funcionalidades do sistema.',
                      ThemeConstants.primaryColor,
                    ),
                    const SizedBox(height: 16),
                    _buildNivelAcesso(
                      'Acesso Tático',
                      'Permissão para visualizar mapas táticos e relatórios, mas sem poder de edição global.',
                      ThemeConstants.accentColor,
                    ),
                    const SizedBox(height: 16),
                    _buildNivelAcesso(
                      'Acesso Limitado',
                      'Permissão básica para registro de ponto e envio de relatórios pessoais.',
                      ThemeConstants.textSecondaryColor,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Seu nível atual
            Card(
              color: ThemeConstants.surfaceColor,
              elevation: ThemeConstants.elevationMedium,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Seu Cargo Atual',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: ThemeConstants.primaryColor,
                          radius: 30,
                          child: const Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user?.cargo ?? 'Membro Novo',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                user?.getCargoDescricao() ?? 'Membro da Federação',
                                style: TextStyle(
                                  color: ThemeConstants.textSecondaryColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getNivelAcessoCor(user?.nivelAcesso ?? 0),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  user?.getNivelAcessoDescricao() ?? 'Acesso Limitado',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
  
  Widget _buildCargoItem(
    String titulo,
    String subtitulo,
    String descricao,
    IconData icone,
    int nivelAcesso,
  ) {
    return ExpansionTile(
      leading: CircleAvatar(
        backgroundColor: ThemeConstants.primaryColor,
        child: Icon(
          icone,
          color: Colors.white,
          size: 20,
        ),
      ),
      title: Text(
        titulo,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Row(
        children: [
          Text(subtitulo),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: _getNivelAcessoCor(nivelAcesso),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              nivelAcesso == 2 ? 'Total' : (nivelAcesso == 1 ? 'Tático' : 'Limitado'),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(
            descricao,
            style: TextStyle(
              color: ThemeConstants.textSecondaryColor,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildNivelAcesso(String titulo, String descricao, Color cor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: cor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                descricao,
                style: TextStyle(
                  color: ThemeConstants.textSecondaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Color _getNivelAcessoCor(int nivel) {
    switch (nivel) {
      case 2:
        return ThemeConstants.primaryColor;
      case 1:
        return ThemeConstants.accentColor;
      default:
        return ThemeConstants.textSecondaryColor;
    }
  }
}
