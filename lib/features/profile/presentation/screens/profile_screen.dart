import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastee/core/constants/app_colors.dart';
import 'package:tastee/core/constants/app_style.dart';
import 'package:tastee/core/theme/theme_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tastee/core/routing/routes.dart';
import 'package:tastee/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:tastee/features/profile/presentation/cubit/profile_states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocProvider(
      create: (context) => ProfileCubit()..getProfile(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Profile",
            style: AppTextStyles.bold18.copyWith(color: colorScheme.onSurface),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<ProfileCubit, ProfileStates>(
          builder: (context, state) {
            String name = "Loading...";
            String email = "Loading...";

            if (state is ProfileSuccess) {
              name = state.profile.name;
              email = state.profile.email;
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  // Profile Header
                  _buildProfileHeader(context, name, email),
                  const SizedBox(height: 32),

                  // Account Section
                  _buildSectionTitle(context, "ACCOUNT"),
                  _buildSectionContainer(context, [
                    _buildSettingsItem(
                      context,
                      icon: Icons.person_outline,
                      title: "Edit Profile",
                    ),
                    _buildSettingsItem(
                      context,
                      icon: Icons.lock_outline,
                      title: "Change Password",
                    ),
                    _buildSettingsItem(
                      context,
                      icon: Icons.notifications_none_outlined,
                      title: "Notification Settings",
                      showBottomDivider: false,
                    ),
                  ]),

                  const SizedBox(height: 24),

                  // Preferences Section
                  _buildSectionTitle(context, "PREFERENCES"),
                  _buildSectionContainer(context, [
                    _buildSettingsItem(
                      context,
                      icon: Icons.dark_mode_outlined,
                      title: "Dark Mode",
                      trailing: BlocBuilder<ThemeCubit, ThemeMode>(
                        builder: (context, themeMode) {
                          return CupertinoSwitch(
                            value: context.read<ThemeCubit>().isDark,
                            onChanged: (_) =>
                                context.read<ThemeCubit>().toggleTheme(),
                            activeTrackColor: AppColors.primary,
                          );
                        },
                      ),
                    ),
                    _buildSettingsItem(
                      context,
                      icon: Icons.language_outlined,
                      title: "Language",
                      trailing: Row(
                        children: [
                          const Text(
                            "English",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.chevron_right,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ],
                      ),
                      showBottomDivider: false,
                    ),
                  ]),

                  const SizedBox(height: 24),

                  // Support Section
                  _buildSectionTitle(context, "SUPPORT"),
                  _buildSectionContainer(context, [
                    _buildSettingsItem(
                      context,
                      icon: Icons.help_outline,
                      title: "Help Center",
                    ),
                    _buildSettingsItem(
                      context,
                      icon: Icons.verified_user_outlined,
                      title: "Privacy Policy",
                    ),
                    _buildSettingsItem(
                      context,
                      icon: Icons.description_outlined,
                      title: "Terms of Service",
                      showBottomDivider: false,
                    ),
                  ]),

                  const SizedBox(height: 32),

                  // Logout Button
                  InkWell(
                    onTap: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                      try {
                        await Supabase.instance.client.auth.signOut();
                        if (context.mounted) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            Routes.login,
                            (route) => false,
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          Navigator.pop(context); // dismiss loading
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Logout failed: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.logout_outlined,
                            color: Colors.red,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Logout",
                            style: AppTextStyles.bold14.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, String name, String email) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.2),
                  width: 3,
                ),
              ),
              child: const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png",
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.edit, color: Colors.white, size: 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          name,
          style: AppTextStyles.bold18.copyWith(
            color: colorScheme.onSurface,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 4),
        Text(email, style: TextStyle(color: Colors.grey[500], fontSize: 14)),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionContainer(BuildContext context, List<Widget> children) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.grey[50],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    Widget? trailing,
    bool showBottomDivider = true,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
              if (trailing != null)
                trailing
              else
                const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
            ],
          ),
        ),
        if (showBottomDivider)
          Padding(
            padding: const EdgeInsets.only(left: 64, right: 16),
            child: Divider(color: Colors.grey.withOpacity(0.1), height: 1),
          ),
      ],
    );
  }
}
