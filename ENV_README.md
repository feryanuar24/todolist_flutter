# Environment Variables Setup

Untuk menjaga keamanan API keys dan konfigurasi Firebase, proyek ini menggunakan environment variables.

## Mengapa Tidak Menggunakan Default Values?

❌ **TIDAK AMAN**:

```dart
apiKey: String.fromEnvironment('API_KEY', defaultValue: 'AIzaSyExample-NEVER-PUT-REAL-API-KEY-HERE')
```

✅ **AMAN**:

```dart
apiKey: String.fromEnvironment('API_KEY')
```

**Alasan:**

- Default values dengan API keys asli tetap terekspos di source code
- Akan ter-commit ke repository dan bisa dilihat siapa saja
- Menghilangkan tujuan utama menggunakan environment variables

## Setup

1. Copy file `.env.example` menjadi `.env`:

   ```bash
   cp .env.example .env
   ```

2. Edit file `.env` dan isi dengan konfigurasi Firebase yang sebenarnya:
   ```
   WEB_API_KEY=your-actual-web-api-key
   ANDROID_API_KEY=your-actual-android-api-key
   # dst...
   ```

## Cara Menjalankan Aplikasi

### Opsi 1: Menggunakan Script (Recommended)

**Windows:**

```bash
./run_with_env.bat
```

**Linux/Mac:**

```bash
chmod +x run_with_env.sh
./run_with_env.sh
```

### Opsi 2: Manual dengan flutter run

```bash
flutter run \
    --dart-define=WEB_API_KEY="your-web-api-key" \
    --dart-define=ANDROID_API_KEY="your-android-api-key" \
    --dart-define=PROJECT_ID="your-project-id" \
    # tambahkan semua environment variables yang dibutuhkan
```

### Opsi 3: Untuk Build Release

```bash
flutter build apk \
    --dart-define=WEB_API_KEY="your-web-api-key" \
    --dart-define=ANDROID_API_KEY="your-android-api-key" \
    --dart-define=PROJECT_ID="your-project-id" \
    # tambahkan semua environment variables yang dibutuhkan
```

## Catatan Penting

- File `.env` sudah ditambahkan ke `.gitignore` dan tidak akan ter-commit ke repository
- Gunakan file `.env.example` sebagai template
- Jangan pernah commit API keys yang sebenarnya ke version control
