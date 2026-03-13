import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static SupabaseClient get client => Supabase.instance.client;

  static Future<void> init() async {
    await Supabase.initialize(
      url:
          'https://stficlrlswlczafuopne.supabase.co', // Add your Supabase URL here
      anonKey:
          'sb_publishable_K-KkJI1Hw3ICzPb8WIgQgA_zAjBRSOP', // Add your Supabase anon key here
    );
  }
}
