import 'package:flutter/material.dart';
import '../utils/theme_constants.dart';
import '../providers/user_provider.dart';
import 'package:provider/provider.dart';

class FotosScreen extends StatefulWidget {
  const FotosScreen({super.key});

  @override
  State<FotosScreen> createState() => _FotosScreenState();
}

class _FotosScreenState extends State<FotosScreen> {
  String _selectedCategory = 'todas';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fotos e Evidências'),
      ),
      body: Column(
        children: [
          // Categorias
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryChip('todas', 'Todas'),
                  _buildCategoryChip('missoes', 'Missões'),
                  _buildCategoryChip('inimigos', 'Inimigos'),
                  _buildCategoryChip('reunioes', 'Reuniões'),
                  _buildCategoryChip('evidencias', 'Evidências'),
                ],
              ),
            ),
          ),
          
          // Galeria de fotos
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemCount: 10, // Número simulado de fotos
              itemBuilder: (context, index) {
                return _buildPhotoItem(index);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ThemeConstants.accentColor,
        onPressed: _showAddPhotoOptions,
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
  
  Widget _buildCategoryChip(String value, String label) {
    final isSelected = _selectedCategory == value;
    
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        selectedColor: ThemeConstants.accentColor,
        backgroundColor: ThemeConstants.surfaceColor,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : ThemeConstants.textColor,
        ),
        onSelected: (selected) {
          if (selected) {
            setState(() {
              _selectedCategory = value;
            });
          }
        },
      ),
    );
  }
  
  Widget _buildPhotoItem(int index) {
    // Simulação de fotos com cores diferentes
    final colors = [
      Colors.red.shade900,
      Colors.blue.shade900,
      Colors.green.shade900,
      Colors.purple.shade900,
      Colors.orange.shade900,
    ];
    
    return InkWell(
      onTap: () => _showPhotoDetails(index),
      child: Container(
        decoration: BoxDecoration(
          color: colors[index % colors.length],
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Placeholder para imagem
            Center(
              child: Icon(
                Icons.photo,
                size: 48,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            
            // Informações da foto
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Foto ${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '22/05/2025',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Categoria
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: ThemeConstants.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _getCategoryName(index),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  String _getCategoryName(int index) {
    final categories = ['Missões', 'Inimigos', 'Reuniões', 'Evidências'];
    return categories[index % categories.length];
  }
  
  void _showPhotoDetails(int index) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: ThemeConstants.backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              title: Text('Foto ${index + 1}'),
              backgroundColor: ThemeConstants.surfaceColor,
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Placeholder para imagem ampliada
                  Container(
                    height: 300,
                    width: double.infinity,
                    color: Colors.grey.shade800,
                    child: const Center(
                      child: Icon(
                        Icons.photo,
                        size: 64,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Detalhes da foto
                  const Text(
                    'Detalhes',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildDetailRow('Nome', 'Foto ${index + 1}'),
                  _buildDetailRow('Categoria', _getCategoryName(index)),
                  _buildDetailRow('Data', '22/05/2025'),
                  _buildDetailRow('Enviado por', 'Membro ${index + 1}'),
                  const SizedBox(height: 16),
                  
                  // Descrição
                  const Text(
                    'Descrição',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Descrição detalhada da foto ${index + 1}. Esta imagem foi capturada durante uma operação tática na Fortaleza Kairo.',
                    style: TextStyle(
                      color: ThemeConstants.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Botões de ação
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        icon: const Icon(Icons.share),
                        label: const Text('Compartilhar'),
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Compartilhamento em desenvolvimento')),
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                      TextButton.icon(
                        icon: const Icon(Icons.delete),
                        label: const Text('Excluir'),
                        style: TextButton.styleFrom(
                          foregroundColor: ThemeConstants.dangerColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Exclusão em desenvolvimento')),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              color: ThemeConstants.textSecondaryColor,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
  
  void _showAddPhotoOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: ThemeConstants.surfaceColor,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                Icons.camera_alt,
                color: ThemeConstants.accentColor,
              ),
              title: const Text('Tirar Foto'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Câmera em desenvolvimento')),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.photo_library,
                color: ThemeConstants.accentColor,
              ),
              title: const Text('Escolher da Galeria'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Galeria em desenvolvimento')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
