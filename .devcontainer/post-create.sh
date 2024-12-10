#!/bin/bash

echo "Iniciando configuração do ambiente Flutter..."

# Atualizar pacotes
echo "Atualizando pacotes do sistema..."
sudo apt-get update && sudo apt-get upgrade -y

# Instalar dependências do Flutter
echo "Instalando dependências do Flutter..."
sudo apt-get install -y curl git unzip xz-utils zip libglu1-mesa clang cmake ninja-build pkg-config libgtk-3-dev libblkid-dev openjdk-11-jdk wget

# Baixar e instalar o Flutter
echo "Baixando e instalando o Flutter versão $FLUTTER_VERSION..."
FLUTTER_VERSION="3.13.9-stable"
curl -O https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_$FLUTTER_VERSION.tar.xz
tar xf flutter_linux_$FLUTTER_VERSION.tar.xz
sudo mv flutter /usr/local/flutter

# Adicionar Flutter ao PATH
echo "Adicionando Flutter ao PATH..."
echo "export PATH=/usr/local/flutter/bin:$PATH" >> ~/.bashrc
source ~/.bashrc

# Baixar e instalar Android SDK Command Line Tools
echo "Baixando e instalando Android SDK Command Line Tools..."
mkdir -p $HOME/Android/cmdline-tools
cd $HOME/Android/cmdline-tools
wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip
unzip commandlinetools-linux-9477386_latest.zip
mv cmdline-tools latest

# Adicionar Android SDK ao PATH
echo "Adicionando Android SDK ao PATH..."
echo "export ANDROID_HOME=$HOME/Android" >> ~/.bashrc
echo "export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH" >> ~/.bashrc
source ~/.bashrc

# Instalar ferramentas e plataformas Android necessárias
echo "Instalando plataformas e ferramentas Android necessárias..."
sdkmanager --install "platform-tools" "platforms;android-33" "build-tools;33.0.2"
sdkmanager --licenses <<EOF
y
y
y
y
y
y
y
y
EOF

# Instalar o Google Chrome
echo "Baixando e instalando o Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb

# Verificar se o Google Chrome foi instalado corretamente
echo "Verificando instalação do Google Chrome..."
which google-chrome
echo "export CHROME_EXECUTABLE=$(which google-chrome)" >> ~/.bashrc
source ~/.bashrc

# Verificar a instalação do Flutter
echo "Verificando a instalação do Flutter..."
cd /workspaces/Flutter/

# Remover o arquivo do Flutter
echo "Removendo o arquivo do Flutter..."
rm -rf flutter_linux_$FLUTTER_VERSION.tar.xz

flutter doctor

echo "Configuração concluída. Ambiente Flutter pronto para uso!"
