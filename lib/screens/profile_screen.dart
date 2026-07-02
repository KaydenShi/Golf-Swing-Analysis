import 'package:flutter/material.dart';
import 'package:golf_swing_analysis/theme/swingpath_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _voiceCoachingEnabled = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                children: [
                  const _ProfileHeader(),
                  const SizedBox(height: 24),
                  const _StatsOverviewCard(),
                  const SizedBox(height: 28),
                  const _SectionLabel(title: 'MY BAG'),
                  const SizedBox(height: 10),
                  _SettingsCard(
                    children: [
                      _SettingsTile(
                        icon: Icons.sports_golf_rounded,
                        iconColor: SwingPathColors.accent,
                        iconBackground: SwingPathColors.accent.withValues(alpha: 0.15),
                        title: 'Driver',
                        subtitle: '10.5° · Stiff shaft',
                        onTap: () {},
                      ),
                      const _SettingsDivider(),
                      _SettingsTile(
                        icon: Icons.golf_course_rounded,
                        iconColor: SwingPathColors.clubSpeed,
                        iconBackground: SwingPathColors.clubSpeed.withValues(alpha: 0.15),
                        title: 'Iron Set',
                        subtitle: '4–PW · Regular flex',
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  const _SectionLabel(title: 'SETTINGS'),
                  const SizedBox(height: 10),
                  _SettingsCard(
                    children: [
                      _SettingsTile(
                        icon: Icons.videocam_rounded,
                        iconColor: SwingPathColors.accent,
                        iconBackground: SwingPathColors.accent.withValues(alpha: 0.15),
                        title: 'Camera & Capture',
                        onTap: () {},
                      ),
                      const _SettingsDivider(),
                      _SettingsTile(
                        icon: Icons.volume_up_rounded,
                        iconColor: SwingPathColors.swings,
                        iconBackground: SwingPathColors.swings.withValues(alpha: 0.15),
                        title: 'Voice Coaching',
                        trailing: Switch.adaptive(
                          value: _voiceCoachingEnabled,
                          activeThumbColor: SwingPathColors.background,
                          activeTrackColor: SwingPathColors.accent,
                          onChanged: (value) =>
                              setState(() => _voiceCoachingEnabled = value),
                        ),
                      ),
                      const _SettingsDivider(),
                      _SettingsTile(
                        icon: Icons.shield_rounded,
                        iconColor: SwingPathColors.clubSpeed,
                        iconBackground: SwingPathColors.clubSpeed.withValues(alpha: 0.15),
                        title: 'Privacy & Data',
                        onTap: () {},
                      ),
                      const _SettingsDivider(),
                      _SettingsTile(
                        icon: Icons.help_outline_rounded,
                        iconColor: const Color(0xFFB07CFF),
                        iconBackground: const Color(0xFFB07CFF).withValues(alpha: 0.15),
                        title: 'Help & Support',
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: SwingPathColors.accent, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: SwingPathColors.accent.withValues(alpha: 0.25),
                    blurRadius: 16,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Container(
                width: 88,
                height: 88,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF3D4F5F), Color(0xFF1E2832)],
                  ),
                ),
                child: const Icon(
                  Icons.person_rounded,
                  size: 48,
                  color: SwingPathColors.textSecondary,
                ),
              ),
            ),
            Positioned(
              right: -2,
              bottom: -2,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFF5C842),
                  border: Border.all(color: SwingPathColors.background, width: 2),
                ),
                child: const Icon(
                  Icons.workspace_premium_rounded,
                  size: 14,
                  color: SwingPathColors.background,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Kayden Shi',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 6),
        Text(
          'Los Osos · Member since 2025',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ProfileBadge(
              icon: Icons.flag_rounded,
              label: 'HCP 14.2',
              backgroundColor: SwingPathColors.accent.withValues(alpha: 0.15),
              foregroundColor: SwingPathColors.accent,
              borderColor: SwingPathColors.accent.withValues(alpha: 0.35),
            ),
            const SizedBox(width: 10),
            _ProfileBadge(
              icon: Icons.star_rounded,
              label: 'Pro Member',
              backgroundColor: const Color(0xFFF5C842).withValues(alpha: 0.15),
              foregroundColor: const Color(0xFFF5C842),
              borderColor: const Color(0xFFF5C842).withValues(alpha: 0.35),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProfileBadge extends StatelessWidget {
  const _ProfileBadge({
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
  });

  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: foregroundColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: foregroundColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsOverviewCard extends StatelessWidget {
  const _StatsOverviewCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: SwingPathColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: SwingPathColors.border),
      ),
      child: const Row(
        children: [
          Expanded(
            child: _StatColumn(
              value: '142',
              label: 'Swings',
              valueColor: SwingPathColors.accent,
            ),
          ),
          _StatDivider(),
          Expanded(
            child: _StatColumn(
              value: '87',
              label: 'Best Score',
              valueColor: SwingPathColors.clubSpeed,
            ),
          ),
          _StatDivider(),
          Expanded(
            child: _StatColumn(
              value: '23',
              label: 'Day Streak',
              valueColor: SwingPathColors.swings,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({
    required this.value,
    required this.label,
    required this.valueColor,
  });

  final String value;
  final String label;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: valueColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 12,
                color: SwingPathColors.textMuted,
              ),
        ),
      ],
    );
  }
}

class _StatDivider extends StatelessWidget {
  const _StatDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 40,
      color: SwingPathColors.border,
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: SwingPathColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: SwingPathColors.border),
      ),
      child: Column(children: children),
    );
  }
}

class _SettingsDivider extends StatelessWidget {
  const _SettingsDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      thickness: 1,
      color: SwingPathColors.border,
      indent: 68,
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: iconBackground,
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 15,
                          ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ],
                ),
              ),
              trailing ??
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: SwingPathColors.textSecondary,
                    size: 24,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
