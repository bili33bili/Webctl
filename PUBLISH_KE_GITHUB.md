# Cara publish webctl ke GitHub

1. Buat repo baru di GitHub, misalnya bernama `webctl` (kosong, tanpa README).
2. Di terminal (Termux/Linux), masuk ke folder proyek ini lalu jalankan:

```bash
cd webctl
git init
git add .
git commit -m "Initial commit: webctl CLI"
git branch -M main
git remote add origin https://github.com/<username-kamu>/webctl.git
git push -u origin main
```

3. Ganti semua `<user>` di README.md dan install.sh dengan username GitHub kamu
   (cari & replace), commit lagi:

```bash
git add README.md install.sh
git commit -m "Update repo URL"
git push
```

4. Setelah itu siapa pun bisa install satu baris:

```bash
curl -fsSL https://raw.githubusercontent.com/<username-kamu>/webctl/main/install.sh | bash
```
