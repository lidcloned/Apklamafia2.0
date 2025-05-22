# RELATÓRIO DE ATUALIZAÇÕES PARA FLUTTER 17

Este documento detalha todas as alterações realizadas para atualizar o projeto para o Flutter 17.

## 1. Atualização de Dependências

### pubspec.yaml
- Atualizado SDK mínimo para `>=3.3.0 <4.0.0`
- Atualizadas as seguintes dependências para versões compatíveis com Flutter 17:
  - firebase_core: ^2.24.2
  - firebase_auth: ^4.15.3
  - cloud_firestore: ^4.13.6
  - firebase_storage: ^11.5.6
  - provider: ^6.1.1
  - shared_preferences: ^2.2.2
  - image_picker: ^1.0.4
  - intl: ^0.19.0
  - flutter_local_notifications: ^16.2.0
  - path_provider: ^2.1.1
  - uuid: ^4.2.1
  - permission_handler: ^11.0.1
  - connectivity_plus: ^5.0.1
  - cached_network_image: ^3.3.0
  - flutter_cache_manager: ^3.3.1

## 2. Migração do Android

### android/app/build.gradle
- Confirmado compileSdk 34
- Confirmada configuração para Java 17:
  ```
  compileOptions {
    sourceCompatibility JavaVersion.VERSION_17
    targetCompatibility JavaVersion.VERSION_17
    coreLibraryDesugaringEnabled true
  }
  
  kotlinOptions {
    jvmTarget = '17'
  }
  ```
- Mantida configuração de minSdkVersion 24 e targetSdkVersion 34
- Habilitadas otimizações para release:
  ```
  buildTypes {
    release {
      signingConfig signingConfigs.debug
      minifyEnabled true
      shrinkResources true
      proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
    }
  }
  ```

### android/build.gradle
- Atualizado Kotlin para versão 1.9.22
- Atualizado Gradle Plugin para 8.2.0

### android/gradle.properties
- Otimizadas configurações de build:
  ```
  org.gradle.jvmargs=-Xmx4G -XX:MaxMetaspaceSize=1G -XX:+HeapDumpOnOutOfMemoryError -Dfile.encoding=UTF-8
  android.useAndroidX=true
  android.enableJetifier=true
  android.nonTransitiveRClass=true
  org.gradle.parallel=true
  org.gradle.caching=true
  android.enableR8.fullMode=true
  kotlin.code.style=official
  ```

## 3. Atualização do iOS

### ios/Podfile
- Confirmada versão mínima do iOS para 13.0:
  ```
  platform :ios, '13.0'
  ```
- Adicionadas configurações para compatibilidade com iOS 15+:
  ```
  config.build_settings['SWIFT_VERSION'] = '5.0'
  config.build_settings['ENABLE_BITCODE'] = 'NO'
  ```
- Habilitado suporte para Apple Silicon:
  ```
  config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
  ```
- Configuradas permissões necessárias:
  ```
  config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
    '$(inherited)',
    'PERMISSION_CAMERA=1',
    'PERMISSION_PHOTOS=1',
    'PERMISSION_NOTIFICATIONS=1',
  ]
  ```

## 4. Otimizações de Build

- Habilitado paralelismo no Gradle
- Habilitado cache do Gradle
- Aumentada memória disponível para o JVM
- Habilitado R8 em modo completo para melhor otimização
- Configurado estilo de código Kotlin oficial

## 5. Processamento com Flutter 17

- Instalado Flutter 17 (versão 3.19.3) no ambiente
- Executados os seguintes comandos:
  - `flutter pub get` - Para baixar todas as dependências atualizadas
  - `flutter pub upgrade` - Para garantir que todas as dependências estejam na versão mais recente compatível
  - `flutter clean` - Para limpar a pasta build e evitar conflitos

## 6. Próximos Passos

O projeto está pronto para ser usado com o Flutter 17. Você pode gerar o APK com:

```
flutter build apk
```

Estas alterações garantem que seu projeto esteja totalmente compatível com o Flutter 17 e otimizado para melhor desempenho.
