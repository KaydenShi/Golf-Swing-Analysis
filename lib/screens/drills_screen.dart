import 'package:flutter/material.dart';
import 'package:golf_swing_analysis/theme/swingpath_theme.dart';

class DrillsScreen extends StatefulWidget {
  const DrillsScreen({super.key});

  @override
  State<DrillsScreen> createState() => _DrillsScreenState();
}

class _DrillsScreenState extends State<DrillsScreen> {
  static const _categories = [
    'For You',
    'Driver',
    'Irons',
    'Putting',
    'Tempo',
  ];

  int _selectedCategory = 0;

  static const _drills = [
    _DrillItem(
      title: 'Wall Posture Hold',
      subtitle: 'Maintain spine angle · 3 min',
      isCompleted: true,
    ),
    _DrillItem(
      title: 'Split Stance Balance',
      subtitle: 'Hip stability at impact · 4 min',
      isCompleted: true,
    ),
    _DrillItem(
      title: 'Alignment Stick Gate',
      subtitle: 'Swing path control · 5 min',
      isCompleted: false,
    ),
    _DrillItem(
      title: 'Slow-Motion Swings',
      subtitle: 'Tempo and sequencing · 6 min',
      isCompleted: false,
    ),
    _DrillItem(
      title: 'Feet-Together Drill',
      subtitle: 'Balance through finish · 3 min',
      isCompleted: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Practice',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'AI-built plan to fix early extension',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  const _WeeklyPlanCard(),
                  const SizedBox(height: 20),
                  _CategoryFilters(
                    categories: _categories,
                    selectedIndex: _selectedCategory,
                    onSelected: (index) =>
                        setState(() => _selectedCategory = index),
                  ),
                  const SizedBox(height: 20),
                  const _NextUpCard(),
                  const SizedBox(height: 28),
                  _DrillLibraryHeader(drillCount: 48),
                  const SizedBox(height: 12),
                  ..._drills.map(
                    (drill) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _DrillListTile(drill: drill),
                    ),
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

class _WeeklyPlanCard extends StatelessWidget {
  const _WeeklyPlanCard();

  @override
  Widget build(BuildContext context) {
    const completed = 2;
    const total = 5;
    const progress = completed / total;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A3D2E), Color(0xFF0F2419), Color(0xFF0A1812)],
        ),
        border: Border.all(color: SwingPathColors.accent.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "THIS WEEK'S PLAN",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: SwingPathColors.accent,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Posture & Path Reset',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              Text(
                '$completed/$total drills',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: SwingPathColors.accent,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: SwingPathColors.border,
              color: SwingPathColors.accent,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Keep going — ${total - completed} drills left to lock in your new posture',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 12,
                ),
          ),
        ],
      ),
    );
  }
}

class _CategoryFilters extends StatelessWidget {
  const _CategoryFilters({
    required this.categories,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<String> categories;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < categories.length; i++) ...[
            if (i > 0) const SizedBox(width: 8),
            _CategoryPill(
              label: categories[i],
              isSelected: selectedIndex == i,
              onTap: () => onSelected(i),
            ),
          ],
        ],
      ),
    );
  }
}

class _CategoryPill extends StatelessWidget {
  const _CategoryPill({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? SwingPathColors.accent : SwingPathColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? SwingPathColors.accent : SwingPathColors.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected
                ? SwingPathColors.background
                : SwingPathColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _NextUpCard extends StatelessWidget {
  const _NextUpCard();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF2A4535), Color(0xFF1A2820), Color(0xFF0F1612)],
              ),
            ),
            child: CustomPaint(painter: _RangePatternPainter()),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.2),
                    Colors.black.withValues(alpha: 0.75),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 14,
            left: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF5A623),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.schedule_rounded, size: 12, color: Colors.black),
                  SizedBox(width: 4),
                  Text(
                    'NEXT UP',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned.fill(
            child: Center(
              child: Icon(
                Icons.play_circle_filled_rounded,
                size: 56,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'The Chair Drill',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: SwingPathColors.focusBlue,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _MetaChip(icon: Icons.schedule_rounded, label: '4 min'),
                    const SizedBox(width: 12),
                    _MetaChip(icon: Icons.bar_chart_rounded, label: 'Beginner'),
                    const SizedBox(width: 12),
                    _MetaChip(
                      icon: Icons.warning_amber_rounded,
                      label: 'Early extension',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: SwingPathColors.accent),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 12,
                color: SwingPathColors.accent,
              ),
        ),
      ],
    );
  }
}

class _DrillLibraryHeader extends StatelessWidget {
  const _DrillLibraryHeader({required this.drillCount});

  final int drillCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Drill Library', style: Theme.of(context).textTheme.titleLarge),
        Text(
          '$drillCount drills',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _DrillItem {
  const _DrillItem({
    required this.title,
    required this.subtitle,
    required this.isCompleted,
  });

  final String title;
  final String subtitle;
  final bool isCompleted;
}

class _DrillListTile extends StatelessWidget {
  const _DrillListTile({required this.drill});

  final _DrillItem drill;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: SwingPathColors.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: SwingPathColors.border),
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: drill.isCompleted
                              ? const [Color(0xFF1A3D2E), Color(0xFF0F2419)]
                              : const [Color(0xFF2A4030), Color(0xFF1A2420)],
                        ),
                      ),
                      child: Icon(
                        drill.isCompleted
                            ? Icons.check_rounded
                            : Icons.play_arrow_rounded,
                        color: drill.isCompleted
                            ? SwingPathColors.accent
                            : SwingPathColors.textMuted,
                        size: 28,
                      ),
                    ),
                  ),
                  if (drill.isCompleted)
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: SwingPathColors.accent.withValues(alpha: 0.12),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      drill.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 15,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      drill.subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 12,
                          ),
                    ),
                  ],
                ),
              ),
              if (drill.isCompleted)
                Text(
                  'DONE',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: SwingPathColors.accent,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                )
              else
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

class _RangePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03)
      ..strokeWidth = 1;

    for (var i = 0; i < 8; i++) {
      final y = size.height * (i / 8);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
