import 'package:flutter/material.dart';
import '../utils/theme_constants.dart';
import '../providers/user_provider.dart';
import 'package:provider/provider.dart';

class RelatorioScreen extends StatefulWidget {
  const RelatorioScreen({super.key});

  @override
  State<RelatorioScreen> createState() => _RelatorioScreenState();
}

class _RelatorioScreenState extends State<RelatorioScreen> {
  int _selectedTabIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Relatórios'),
          bottom: TabBar(
            onTap: (index) {
              setState(() {
                _selectedTabIndex = index;
              });
            },
            tabs: const [
              Tab(text: 'CRIAR'),
              Tab(text: 'HISTÓRICO'),
              Tab(text: 'TESTE ALRO'),
            ],
            labelColor: ThemeConstants.accentColor,
            unselectedLabelColor: ThemeConstants.textSecondaryColor,
            indicatorColor: ThemeConstants.accentColor,
          ),
        ),
        body: TabBarView(
          children: [
            _buildCriarRelatorioTab(),
            _buildHistoricoTab(),
            _buildTesteALROTab(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCriarRelatorioTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Novo Relatório',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ThemeConstants.textColor,
            ),
          ),
          const SizedBox(height: 16),
          
          // Formulário de relatório
          Card(
            color: ThemeConstants.surfaceColor,
            elevation: ThemeConstants.elevationMedium,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tipo de relatório
                  const Text(
                    'Tipo de Relatório',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    value: 'missao',
                    items: const [
                      DropdownMenuItem(
                        value: 'missao',
                        child: Text('Relatório de Missão'),
                      ),
                      DropdownMenuItem(
                        value: 'atividade',
                        child: Text('Relatório de Atividade'),
                      ),
                      DropdownMenuItem(
                        value: 'incidente',
                        child: Text('Relatório de Incidente'),
                      ),
                      DropdownMenuItem(
                        value: 'reconhecimento',
                        child: Text('Relatório de Reconhecimento'),
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 16),
                  
                  // Título
                  const Text(
                    'Título',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Digite um título para o relatório',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Descrição
                  const Text(
                    'Descrição',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Descreva detalhadamente o ocorrido',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 5,
                  ),
                  const SizedBox(height: 16),
                  
                  // Data e hora
                  const Text(
                    'Data e Hora',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Data',
                            prefixIcon: Icon(Icons.calendar_today),
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true,
                          onTap: () {
                            // Abrir seletor de data
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Hora',
                            prefixIcon: Icon(Icons.access_time),
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true,
                          onTap: () {
                            // Abrir seletor de hora
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Anexar foto
                  const Text(
                    'Anexos',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.photo_camera),
                    label: const Text('Anexar Foto'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: ThemeConstants.accentColor,
                      side: BorderSide(color: ThemeConstants.accentColor),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                    onPressed: () {
                      // Abrir câmera ou galeria
                    },
                  ),
                  const SizedBox(height: 24),
                  
                  // Botão de envio
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeConstants.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        // Enviar relatório
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Relatório enviado com sucesso!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      child: const Text('ENVIAR RELATÓRIO'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildHistoricoTab() {
    // Lista simulada de relatórios
    final relatorios = List.generate(
      10,
      (index) => {
        'id': index + 1,
        'titulo': 'Relatório #${index + 1}',
        'tipo': index % 4 == 0 ? 'missao' : (index % 4 == 1 ? 'atividade' : (index % 4 == 2 ? 'incidente' : 'reconhecimento')),
        'data': '${(index + 1) % 30}/${(index % 12) + 1}/2025',
        'status': index % 3 == 0 ? 'aprovado' : (index % 3 == 1 ? 'pendente' : 'rejeitado'),
      },
    );
    
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: relatorios.length,
      itemBuilder: (context, index) {
        final relatorio = relatorios[index];
        return Card(
          color: ThemeConstants.surfaceColor,
          elevation: ThemeConstants.elevationMedium,
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _getStatusColor(relatorio['status'] as String),
              child: Icon(
                _getTipoIcon(relatorio['tipo'] as String),
                color: Colors.white,
                size: 20,
              ),
            ),
            title: Text(relatorio['titulo'] as String),
            subtitle: Text('${_getTipoNome(relatorio['tipo'] as String)} • ${relatorio['data']}'),
            trailing: Chip(
              label: Text(
                _getStatusNome(relatorio['status'] as String),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
              backgroundColor: _getStatusColor(relatorio['status'] as String),
            ),
            onTap: () {
              // Abrir detalhes do relatório
            },
          ),
        );
      },
    );
  }
  
  Widget _buildTesteALROTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Teste ALRO',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ThemeConstants.textColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Avaliação de Lealdade e Relatório Operacional',
            style: TextStyle(
              color: ThemeConstants.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 24),
          
          // Questionário ALRO
          Card(
            color: ThemeConstants.surfaceColor,
            elevation: ThemeConstants.elevationMedium,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Responda às seguintes questões com sinceridade:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Questões
                  _buildQuestao(
                    1,
                    'Você conhece todos os membros da sua equipe atual?',
                    ['Sim, todos', 'A maioria', 'Apenas alguns', 'Não conheço'],
                  ),
                  const Divider(),
                  _buildQuestao(
                    2,
                    'Quantas horas semanais você dedica às atividades do clã?',
                    ['Menos de 5h', 'Entre 5h e 10h', 'Entre 10h e 20h', 'Mais de 20h'],
                  ),
                  const Divider(),
                  _buildQuestao(
                    3,
                    'Você já identificou comportamentos suspeitos entre membros?',
                    ['Nunca', 'Raramente', 'Ocasionalmente', 'Frequentemente'],
                  ),
                  const Divider(),
                  _buildQuestao(
                    4,
                    'Como você avalia seu conhecimento sobre a estrutura do clã?',
                    ['Excelente', 'Bom', 'Regular', 'Insuficiente'],
                  ),
                  const Divider(),
                  _buildQuestao(
                    5,
                    'Você seguiria ordens mesmo discordando delas?',
                    ['Sempre', 'Na maioria das vezes', 'Depende da ordem', 'Raramente'],
                  ),
                  const SizedBox(height: 24),
                  
                  // Comentários adicionais
                  const Text(
                    'Comentários Adicionais',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Compartilhe informações adicionais que julgar relevantes',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),
                  
                  // Botão de envio
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeConstants.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        // Enviar teste ALRO
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Teste ALRO enviado com sucesso!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      child: const Text('ENVIAR TESTE ALRO'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildQuestao(int numero, String pergunta, List<String> opcoes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$numero. $pergunta',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        ...opcoes.map((opcao) => RadioListTile<String>(
          title: Text(opcao),
          value: opcao,
          groupValue: null, // Valor selecionado
          onChanged: (value) {
            // Atualizar resposta
          },
          activeColor: ThemeConstants.accentColor,
          contentPadding: EdgeInsets.zero,
          dense: true,
        )).toList(),
      ],
    );
  }
  
  Color _getStatusColor(String status) {
    switch (status) {
      case 'aprovado':
        return Colors.green;
      case 'pendente':
        return Colors.orange;
      case 'rejeitado':
        return Colors.red;
      default:
        return ThemeConstants.primaryColor;
    }
  }
  
  IconData _getTipoIcon(String tipo) {
    switch (tipo) {
      case 'missao':
        return Icons.assignment;
      case 'atividade':
        return Icons.event;
      case 'incidente':
        return Icons.warning;
      case 'reconhecimento':
        return Icons.search;
      default:
        return Icons.description;
    }
  }
  
  String _getTipoNome(String tipo) {
    switch (tipo) {
      case 'missao':
        return 'Missão';
      case 'atividade':
        return 'Atividade';
      case 'incidente':
        return 'Incidente';
      case 'reconhecimento':
        return 'Reconhecimento';
      default:
        return 'Relatório';
    }
  }
  
  String _getStatusNome(String status) {
    switch (status) {
      case 'aprovado':
        return 'APROVADO';
      case 'pendente':
        return 'PENDENTE';
      case 'rejeitado':
        return 'REJEITADO';
      default:
        return status.toUpperCase();
    }
  }
}
