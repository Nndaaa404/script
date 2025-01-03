#!/bin/bash

# Pastikan script dijalankan sebagai root
if [ "$EUID" -ne 0 ]; then
  echo "Harap jalankan script ini sebagai root."
  exit
fi

echo "Memperbarui daftar paket..."
sudo apt update

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

# Menghapus file setup_ssh.sh setelah semua perintah selesai
echo "Menghapus file setup_ssh.sh..."
rm -- "$0"  # Menghapus script yang sedang berjalan

echo "File setup_ssh.sh telah dihapus."
