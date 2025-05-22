import 'package:flutter/material.dart';
import '../utils/theme_constants.dart';
import '../models/user_model.dart';

class UserModel {
  final String uid;
  final String username;
  final String email;
  final String gameName;
  final String whatsapp;
  final String role; // 'owner', 'admin', 'member'
  final int level;
  final int hoursPlayed;
  final int points;
  final String profileImageUrl;
  final String joinDate;
  final bool isAdmin;
  final String cargo; // Cargo sinistro específico do LaMafia
  final String especialidade;
  final int nivelAcesso; // 0: Limitado, 1: Tático, 2: Total

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.gameName,
    required this.whatsapp,
    required this.role,
    this.level = 1,
    this.hoursPlayed = 0,
    this.points = 0,
    this.profileImageUrl = '',
    required this.joinDate,
    this.isAdmin = false,
    this.cargo = 'Membro Novo',
    this.especialidade = 'Não definida',
    this.nivelAcesso = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'gameName': gameName,
      'whatsapp': whatsapp,
      'role': role,
      'level': level,
      'hoursPlayed': hoursPlayed,
      'points': points,
      'profileImageUrl': profileImageUrl,
      'joinDate': joinDate,
      'isAdmin': isAdmin,
      'cargo': cargo,
      'especialidade': especialidade,
      'nivelAcesso': nivelAcesso,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      gameName: map['gameName'] ?? '',
      whatsapp: map['whatsapp'] ?? '',
      role: map['role'] ?? 'member',
      level: map['level'] ?? 1,
      hoursPlayed: map['hoursPlayed'] ?? 0,
      points: map['points'] ?? 0,
      profileImageUrl: map['profileImageUrl'] ?? '',
      joinDate: map['joinDate'] ?? '',
      isAdmin: map['isAdmin'] ?? false,
      cargo: map['cargo'] ?? 'Membro Novo',
      especialidade: map['especialidade'] ?? 'Não definida',
      nivelAcesso: map['nivelAcesso'] ?? 0,
    );
  }

  UserModel copyWith({
    String? uid,
    String? username,
    String? email,
    String? gameName,
    String? whatsapp,
    String? role,
    int? level,
    int? hoursPlayed,
    int? points,
    String? profileImageUrl,
    String? joinDate,
    bool? isAdmin,
    String? cargo,
    String? especialidade,
    int? nivelAcesso,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      email: email ?? this.email,
      gameName: gameName ?? this.gameName,
      whatsapp: whatsapp ?? this.whatsapp,
      role: role ?? this.role,
      level: level ?? this.level,
      hoursPlayed: hoursPlayed ?? this.hoursPlayed,
      points: points ?? this.points,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      joinDate: joinDate ?? this.joinDate,
      isAdmin: isAdmin ?? this.isAdmin,
      cargo: cargo ?? this.cargo,
      especialidade: especialidade ?? this.especialidade,
      nivelAcesso: nivelAcesso ?? this.nivelAcesso,
    );
  }
  
  // Obter descrição do cargo sinistro
  String getCargoDescricao() {
    switch (cargo) {
      case 'OLHO CORTANTE':
        return 'Vigilância total';
      case 'VOZ SOMBRIA':
        return 'Intermediador';
      case 'FANTASMA DA BASE':
        return 'Executor de contra-infiltração';
      case 'DÍZIMO NEGRO':
        return 'Gerente de recursos';
      case 'PALMA DO JULGAMENTO':
        return 'Responsável por testes/relatórios';
      case 'VÉU DE BRASA':
        return 'Líder de infiltração/rastreamento';
      case 'GRITO MUDO':
        return 'Guardião dos segredos';
      case 'VÁCUO AZUL':
        return 'Controle de mapas/rotas';
      default:
        return 'Membro da Federação';
    }
  }
  
  // Obter descrição do nível de acesso
  String getNivelAcessoDescricao() {
    switch (nivelAcesso) {
      case 0:
        return 'Acesso Limitado';
      case 1:
        return 'Acesso Tático';
      case 2:
        return 'Acesso Total';
      default:
        return 'Acesso Limitado';
    }
  }
  
  // Verificar se tem permissão para determinada ação
  bool temPermissao(String permissao) {
    // Se for idcloned, tem todas as permissões
    if (gameName.toLowerCase() == 'idcloned') {
      return true;
    }
    
    // Permissões baseadas no nível de acesso
    switch (permissao) {
      case 'editar_mapa':
        return nivelAcesso >= 1;
      case 'gerenciar_membros':
        return nivelAcesso >= 2;
      case 'modo_alerta':
        return nivelAcesso >= 2;
      case 'ver_relatorios':
        return nivelAcesso >= 1;
      case 'editar_estrutura':
        return nivelAcesso >= 2;
      default:
        return nivelAcesso >= 2;
    }
  }
}
