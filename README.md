# webctl

Tools CLI untuk menjalankan dan mengelola website lokal langsung dari
**Termux (Android)**, **Linux**, **WSL/CMD**, atau terminal mana pun —
dari folder biasa atau file **.zip** — lengkap dengan log server, health
check, matikan server, dukungan plugin tambahan, dan modul uji keamanan
dasar **ke server milikmu sendiri saja**.

> ⚠️ **PERINGATAN KERAS / DISCLAIMER**
>
> Modul `selftest` di tools ini **HANYA** boleh dipakai untuk menguji
> server yang kamu jalankan sendiri lewat `webctl run` (localhost / LAN
> milikmu). Tools ini **sengaja menolak** target di luar itu — tidak ada
> cara untuk mengarahkannya ke domain atau IP publik milik orang lain.
>
> Menyerang, membobol, atau membebani server/web milik orang lain tanpa
> izin adalah **tindak pidana** (contoh: UU ITE Pasal 30 & 32 di
> Indonesia, dan hukum serupa di hampir semua negara). Segala
> penyalahgunaan di luar tujuan "lab pribadi / belajar keamanan di server
> sendiri" sepenuhnya tanggung jawab pengguna. **Jangan pernah
> disalahgunakan.**

---

## Fitur

| Perintah | Fungsi |
|---|---|
| `webctl run <folder\|file.zip>` | Jalankan web dari folder atau ekstrak otomatis dari `.zip`, lalu serve |
| `webctl list` | Daftar semua server yang tercatat (nama, port, status, PID) |
| `webctl health [nama]` | Cek kesehatan: proses hidup/mati + probe HTTP |
| `webctl log <nama> [--follow]` | Lihat log server (mode `--follow` = live seperti `tail -f`) |
| `webctl stop <nama\|all>` | Matikan satu server atau semua sekaligus |
| `webctl selftest <nama> [--deep]` | Uji keamanan dasar + load test ringan **ke server sendiri** |
| `webctl plugin list\|install\|run` | Kelola & jalankan plugin tambahan (`.sh`) |
| `webctl version` / `webctl help` | Info versi & bantuan |

### Yang dicek `selftest`
1. Server hidup & waktu respons
2. Header keamanan dasar (`X-Content-Type-Options`, `X-Frame-Options`, `CSP`, `HSTS`)
3. File/endpoint sensitif yang mungkin ke-expose (`.env`, `.git/config`, `wp-config.php`, dll)
4. Load test ringan (paralel request lokal) untuk lihat ketahanan server kecil

Bukan pengganti audit keamanan profesional — ini alat bantu belajar &
cek cepat sebelum kamu publish web sendiri.

---

## Instalasi

### Termux (Android)
```bash
pkg update && pkg install -y python git curl unzip
git clone https://github.com/<user>/webctl.git
cd webctl
bash install.sh
source ~/.bashrc   # atau buka sesi Termux baru
webctl help
```

### Linux / WSL
```bash
sudo apt update && sudo apt install -y python3 curl unzip   # Debian/Ubuntu
git clone https://github.com/<user>/webctl.git
cd webctl
bash install.sh
source ~/.bashrc
webctl help
```

### Install langsung (1 baris, setelah repo di-publish ke GitHub)
```bash
curl -fsSL https://raw.githubusercontent.com/<user>/webctl/main/install.sh | bash
```

### Windows (CMD/PowerShell)
Pakai WSL (disarankan) lalu ikuti langkah Linux di atas, atau jalankan
lewat Git Bash yang sudah include `bash`.

> Ganti `<user>` di atas dengan username GitHub kamu setelah repo dipublish.

---

## Cara Pakai

```bash
# 1. Jalankan web dari folder
webctl run ./situs-saya --name situs --port 8080

# 2. Jalankan dari file zip (otomatis diekstrak)
webctl run project.zip --name project

# 3. Lihat daftar server
webctl list

# 4. Lihat log realtime
webctl log situs --follow

# 5. Cek kesehatan
webctl health situs

# 6. Uji keamanan dasar ke server sendiri
webctl selftest situs
webctl selftest situs --deep     # load test lebih berat (tetap lokal)

# 7. Matikan server
webctl stop situs
webctl stop all
```

### Opsi `run`
```
webctl run <folder|zip> [opsi]
  --port <n>     Port (default: cari otomatis mulai 8000)
  --bind <addr>  Alamat bind (default: 127.0.0.1)
  --name <nama>  Nama server untuk log/stop/status
  --fg           Jalankan foreground (bukan background)
  --open         Coba buka browser otomatis
```

---

## Plugin

Plugin adalah file `.sh` biasa yang bisa kamu taruh di
`~/.webctl/plugins/`.

```bash
# Pasang plugin
webctl plugin install plugins/example-portcheck.sh

# Lihat plugin terpasang
webctl plugin list

# Jalankan plugin
webctl plugin run example-portcheck 8000 8080
```

Contoh plugin (`plugins/example-portcheck.sh`) sudah disediakan di
repo ini sebagai template — tinggal copy & modifikasi untuk kebutuhanmu
(misalnya: backup otomatis, notifikasi Telegram saat server down, dll).

---

## Struktur Data

Semua data runtime webctl disimpan di `~/.webctl/`:
```
~/.webctl/
├── run/       # file .pid dan .meta tiap server
├── logs/      # log tiap server (<nama>.log)
├── sites/     # hasil ekstrak zip
└── plugins/   # plugin .sh terpasang
```

---

## Kontribusi

Pull request terbuka untuk:
- Dukungan server engine lain (node, caddy, dll)
- Plugin baru (taruh di folder `plugins/`)
- Perbaikan modul `selftest` (tetap harus dibatasi ke localhost/LAN sendiri)

## Lisensi

MIT — pakai bebas, tapi ingat disclaimer di atas: **jangan pernah
dipakai untuk menyerang web orang lain tanpa izin.**
