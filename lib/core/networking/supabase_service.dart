import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static SupabaseClient get client => Supabase.instance.client;

  static Future<void> init() async {
    await Supabase.initialize(
      url: '', // Add your Supabase URL here
      anonKey: '', // Add your Supabase anon key here
    );
  }
}
