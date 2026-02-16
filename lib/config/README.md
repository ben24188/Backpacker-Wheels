# Config Setup

## Supabase Konfiguration

Die Datei `supabase_config.dart` enthält sensible API Keys und ist in `.gitignore`.

### Setup für andere Entwickler:

1. Kopiere `supabase_config.dart.template` zu `supabase_config.dart`:
   ```bash
   copy supabase_config.dart.template supabase_config.dart
   ```

2. Öffne `supabase_config.dart` und füge deine echten Werte ein:
   ```dart
   static const String supabaseUrl = 'https://dein-projekt.supabase.co';
   static const String supabaseAnonKey = 'dein-anon-key-hier';
   ```

3. Die Datei wird automatisch von Git ignoriert (siehe `.gitignore`)

## Sicherheit

⚠️ **Niemals echte API Keys committen!**
- `supabase_config.dart` ist in `.gitignore`
- Nur das Template wird versioniert
- Jeder Entwickler muss seine eigene Config erstellen
