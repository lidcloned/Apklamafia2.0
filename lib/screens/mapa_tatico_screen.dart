import 'package:flutter/material.dart';
import '../utils/theme_constants.dart';
import '../providers/user_provider.dart';
import 'package:provider/provider.dart';

class MapaTaticoScreen extends StatefulWidget {
  const MapaTaticoScreen({super.key});

  @override
  State<MapaTaticoScreen> createState() => _MapaTaticoScreenState();
}

class _MapaTaticoScreenState extends State<MapaTaticoScreen> {
  int _selectedPointIndex = -1;
  bool _isEditMode = false;
  
  // Pontos estratégicos simulados
  final List<Map<String, dynamic>> _pontos = [
    {
      'id': 1,
      'nome': 'Entrada Principal',
      'descricao': 'Ponto de acesso principal à Fortaleza Kairo',
      'coordX': 0.2,
      'coordY': 0.3,
      'tipo': 'acesso',
    },
    {
      'id': 2,
      'nome': 'Torre de Vigilância',
      'descricao': 'Ponto de observação elevado com visão panorâmica',
      'coordX': 0.7,
      'coordY': 0.2,
      'tipo': 'vigilancia',
    },
    {
      'id': 3,
      'nome': 'Depósito de Suprimentos',
      'descricao': 'Armazenamento de recursos e equipamentos',
      'coordX': 0.5,
      'coordY': 0.6,
      'tipo': 'recursos',
    },
    {
      'id': 4,
      'nome': 'Sala de Comunicações',
      'descricao': 'Centro de controle e comunicação tática',
      'coordX': 0.3,
      'coordY': 0.8,
      'tipo': 'comunicacao',
    },
    {
      'id': 5,
      'nome': 'Saída de Emergência',
      'descricao': 'Rota de fuga secundária',
      'coordX': 0.8,
      'coordY': 0.7,
      'tipo': 'acesso',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    final bool canEdit = user?.temPermissao('editar_mapa') ?? false;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa Tático'),
        actions: [
          // Botão de edição (apenas para usuários com permissão)
          if (canEdit)
            IconButton(
              icon: Icon(_isEditMode ? Icons.check : Icons.edit),
              onPressed: () {
                setState(() {
                  _isEditMode = !_isEditMode;
                  if (!_isEditMode) {
                    _selectedPointIndex = -1;
                  }
                });
              },
            ),
        ],
      ),
      body: Stack(
        children: [
          // Mapa base
          Image.asset(
            'assets/images/mapa_base.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          
          // Pontos estratégicos
          ..._pontos.asMap().entries.map((entry) {
            final index = entry.key;
            final ponto = entry.value;
            return Positioned(
              left: MediaQuery.of(context).size.width * ponto['coordX'],
              top: MediaQuery.of(context).size.height * ponto['coordY'],
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedPointIndex = index;
                  });
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: _getPointColor(ponto['tipo']),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _selectedPointIndex == index
                          ? Colors.white
                          : Colors.transparent,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    _getPointIcon(ponto['tipo']),
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            );
          }).toList(),
          
          // Painel de informações do ponto selecionado
          if (_selectedPointIndex >= 0)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: ThemeConstants.surfaceColor.withOpacity(0.9),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _pontos[_selectedPointIndex]['nome'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            setState(() {
                              _selectedPointIndex = -1;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _pontos[_selectedPointIndex]['descricao'],
                      style: TextStyle(
                        color: ThemeConstants.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Botões de ação (apenas em modo de edição)
                        if (_isEditMode)
                          TextButton.icon(
                            icon: const Icon(Icons.edit),
                            label: const Text('Editar'),
                            onPressed: () {
                              // Abrir diálogo de edição
                              _showEditDialog(_selectedPointIndex);
                            },
                          ),
                        if (_isEditMode)
                          TextButton.icon(
                            icon: const Icon(Icons.delete),
                            label: const Text('Excluir'),
                            style: TextButton.styleFrom(
                              foregroundColor: ThemeConstants.dangerColor,
                            ),
                            onPressed: () {
                              // Confirmar exclusão
                              _showDeleteConfirmation(_selectedPointIndex);
                            },
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      // Botão para adicionar novo ponto (apenas em modo de edição)
      floatingActionButton: _isEditMode
          ? FloatingActionButton(
              backgroundColor: ThemeConstants.accentColor,
              child: const Icon(Icons.add),
              onPressed: () {
                // Abrir diálogo para adicionar novo ponto
                _showAddDialog();
              },
            )
          : null,
    );
  }
  
  Color _getPointColor(String tipo) {
    switch (tipo) {
      case 'acesso':
        return Colors.green;
      case 'vigilancia':
        return Colors.blue;
      case 'recursos':
        return Colors.orange;
      case 'comunicacao':
        return Colors.purple;
      default:
        return ThemeConstants.primaryColor;
    }
  }
  
  IconData _getPointIcon(String tipo) {
    switch (tipo) {
      case 'acesso':
        return Icons.door_front_door;
      case 'vigilancia':
        return Icons.visibility;
      case 'recursos':
        return Icons.inventory;
      case 'comunicacao':
        return Icons.settings_phone;
      default:
        return Icons.location_on;
    }
  }
  
  void _showEditDialog(int index) {
    // Implementação do diálogo de edição
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Ponto'),
        content: const Text('Funcionalidade em desenvolvimento'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
  
  void _showDeleteConfirmation(int index) {
    // Implementação da confirmação de exclusão
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text('Deseja realmente excluir o ponto "${_pontos[index]['nome']}"?'),
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
              setState(() {
                _pontos.removeAt(index);
                _selectedPointIndex = -1;
              });
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }
  
  void _showAddDialog() {
    // Implementação do diálogo de adição
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adicionar Ponto'),
        content: const Text('Funcionalidade em desenvolvimento'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
}
