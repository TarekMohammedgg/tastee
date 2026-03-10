import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastee/core/constants/app_colors.dart';
import 'package:tastee/core/constants/app_style.dart';
import 'package:tastee/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:tastee/features/profile/presentation/cubit/profile_states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getProfile(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Profile",
            style: AppTextStyles.bold18.copyWith(color: Colors.black),
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
                  _buildProfileHeader(name, email),
                  const SizedBox(height: 32),

                  // Account Section
                  _buildSectionTitle("ACCOUNT"),
                  _buildSectionContainer([
                    _buildSettingsItem(
                      icon: Icons.person_outline,
                      title: "Edit Profile",
                    ),
                    _buildSettingsItem(
                      icon: Icons.lock_outline,
                      title: "Change Password",
                    ),
                    _buildSettingsItem(
                      icon: Icons.notifications_none_outlined,
                      title: "Notification Settings",
                      showBottomDivider: false,
                    ),
                  ]),

                  const SizedBox(height: 24),

                  // Preferences Section
                  _buildSectionTitle("PREFERENCES"),
                  _buildSectionContainer([
                    _buildSettingsItem(
                      icon: Icons.dark_mode_outlined,
                      title: "Dark Mode",
                      trailing: CupertinoSwitch(
                        value: false,
                        onChanged: (val) {},
                        activeColor: AppColors.primary,
                      ),
                    ),
                    _buildSettingsItem(
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
                  _buildSectionTitle("SUPPORT"),
                  _buildSectionContainer([
                    _buildSettingsItem(
                      icon: Icons.help_outline,
                      title: "Help Center",
                    ),
                    _buildSettingsItem(
                      icon: Icons.verified_user_outlined,
                      title: "Privacy Policy",
                    ),
                    _buildSettingsItem(
                      icon: Icons.description_outlined,
                      title: "Terms of Service",
                      showBottomDivider: false,
                    ),
                  ]),

                  const SizedBox(height: 32),

                  // Logout Button
                  InkWell(
                    onTap: () {},
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

  Widget _buildProfileHeader(String name, String email) {
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
            color: AppColors.backgroundDark,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 4),
        Text(email, style: TextStyle(color: Colors.grey[500], fontSize: 14)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
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

  Widget _buildSectionContainer(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    Widget? trailing,
    bool showBottomDivider = true,
  }) {
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
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.backgroundDark,
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
