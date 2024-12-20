#!/bin/bash

# Pastikan script dijalankan sebagai root
if [ "$EUID" -ne 0 ]; then
  echo "Harap jalankan script ini sebagai root."
  exit
fi

echo "Memperbarui daftar paket..."
sudo apt update

# Menanyakan apakah akan melanjutkan dengan upgrade
read -p "Apakah Anda ingin melanjutkan dengan upgrade sistem? (y/n): " jawab
if [[ "$jawab" =~ ^[Yy]$ ]]; then
  echo "Meng-upgrade sistem..."
  sudo apt upgrade -y
else
  echo "Upgrade dibatalkan, melanjutkan ke langkah berikutnya..."
fi

echo "Menginstal OpenSSH Server..."
sudo apt install openssh-server -y

echo "Memulai layanan SSH..."
sudo systemctl start ssh

echo "Mengaktifkan layanan SSH agar berjalan otomatis saat boot..."
sudo systemctl enable ssh

echo "Memastikan firewall UFW terinstal..."
sudo apt install ufw -y

echo "Mengizinkan koneksi SSH melalui firewall..."
sudo ufw allow ssh

echo "Mengaktifkan firewall..."
sudo ufw enable

echo "Memulai ulang layanan SSH..."
sudo systemctl restart ssh

echo "Konfigurasi selesai. SSH Server telah diatur dan berjalan."
