import 'package:flutter/material.dart';
import 'package:golf_swing_analysis/theme/swingpath_theme.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  int _selectedPeriod = 0;

  static const _periods = ['8W', '6M', '1Y'];

  static const _milestones = [
    _Milestone(
      title: 'First Birdie',
      icon: Icons.emoji_events_rounded,
      color: Color(0xFFF5C842),
    ),
    _Milestone(
      title: '7-Day Streak',
      icon: Icons.local_fire_department_rounded,
      color: Color(0xFFFF8C42),
    ),
    _Milestone(
      title: 'Sub-15 HCP',
      icon: Icons.trending_down_rounded,
      color: SwingPathColors.accent,
    ),
    _Milestone(
      title: '100 Swings',
      icon: Icons.sports_golf_rounded,
      color: SwingPathColors.swings,
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
                  _ProgressHeader(
                    periods: _periods,
                    selectedPeriod: _selectedPeriod,
                    onPeriodSelected: (index) =>
                        setState(() => _selectedPeriod = index),
                  ),
                  const SizedBox(height: 24),
                  const _HandicapTrendCard(),
                  const SizedBox(height: 16),
                  const _MetricsGrid(),
                  const SizedBox(height: 16),
                  const _FaultFrequencyCard(),
                  const SizedBox(height: 28),
                  _MilestonesSection(milestones: _milestones),
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

class _ProgressHeader extends StatelessWidget {
  const _ProgressHeader({
    required this.periods,
    required this.selectedPeriod,
    required this.onPeriodSelected,
  });

  final List<String> periods;
  final int selectedPeriod;
  final ValueChanged<int> onPeriodSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Progress',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 6),
              Text(
                'Last 8 weeks',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: SwingPathColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: SwingPathColors.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < periods.length; i++)
                _PeriodPill(
                  label: periods[i],
                  isSelected: selectedPeriod == i,
                  onTap: () => onPeriodSelected(i),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PeriodPill extends StatelessWidget {
  const _PeriodPill({
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
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? SwingPathColors.accent : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: isSelected
                ? SwingPathColors.background
                : SwingPathColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _HandicapTrendCard extends StatelessWidget {
  const _HandicapTrendCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: SwingPathColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: SwingPathColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'HANDICAP INDEX',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: SwingPathColors.accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Trending down',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: SwingPathColors.accent,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                '14.2',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: SwingPathColors.textPrimary,
                  height: 1,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: SwingPathColors.accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_downward_rounded,
                      size: 12,
                      color: SwingPathColors.accent,
                    ),
                    SizedBox(width: 2),
                    Text(
                      '4.2',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: SwingPathColors.accent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 120,
            width: double.infinity,
            child: CustomPaint(
              painter: _HandicapChartPainter(),
              child: const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _ChartLabel(label: 'Wk 1', value: '18.4'),
                    _ChartLabel(label: 'Wk 4', value: null),
                    _ChartLabel(label: 'Now', value: '14.2'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartLabel extends StatelessWidget {
  const _ChartLabel({required this.label, this.value});

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (value != null) ...[
          Text(
            value!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 11,
                  color: SwingPathColors.textSecondary,
                ),
          ),
          const SizedBox(height: 2),
        ],
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 11,
                color: SwingPathColors.textMuted,
              ),
        ),
      ],
    );
  }
}

class _HandicapChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const points = [
      Offset(0.0, 0.15),
      Offset(0.18, 0.28),
      Offset(0.35, 0.22),
      Offset(0.52, 0.45),
      Offset(0.68, 0.55),
      Offset(0.82, 0.72),
      Offset(1.0, 0.88),
    ];

    final linePath = Path();
    final fillPath = Path();

    for (var i = 0; i < points.length; i++) {
      final x = points[i].dx * size.width;
      final y = points[i].dy * (size.height - 24);

      if (i == 0) {
        linePath.moveTo(x, y);
        fillPath.moveTo(x, size.height - 24);
        fillPath.lineTo(x, y);
      } else {
        final prev = points[i - 1];
        final prevX = prev.dx * size.width;
        final prevY = prev.dy * (size.height - 24);
        final cpX = (prevX + x) / 2;
        linePath.cubicTo(cpX, prevY, cpX, y, x, y);
        fillPath.cubicTo(cpX, prevY, cpX, y, x, y);
      }
    }

    fillPath.lineTo(size.width, size.height - 24);
    fillPath.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          SwingPathColors.accent.withValues(alpha: 0.35),
          SwingPathColors.accent.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(fillPath, fillPaint);

    final linePaint = Paint()
      ..color = SwingPathColors.accent
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(linePath, linePaint);

    final last = points.last;
    canvas.drawCircle(
      Offset(last.dx * size.width, last.dy * (size.height - 24)),
      5,
      Paint()..color = SwingPathColors.accent,
    );
    canvas.drawCircle(
      Offset(last.dx * size.width, last.dy * (size.height - 24)),
      8,
      Paint()
        ..color = SwingPathColors.accent.withValues(alpha: 0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MetricsGrid extends StatelessWidget {
  const _MetricsGrid();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _MetricCard(
                icon: Icons.speed_rounded,
                iconColor: SwingPathColors.clubSpeed,
                label: 'Club Speed',
                value: '96 mph',
                delta: '+4 mph',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _MetricCard(
                icon: Icons.adjust_rounded,
                iconColor: SwingPathColors.accent,
                label: 'Consistency',
                value: '82%',
                delta: '+11%',
                valueColor: SwingPathColors.accent,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _MetricCard(
                icon: Icons.waves_rounded,
                iconColor: SwingPathColors.swings,
                label: 'Avg Carry',
                value: '254 yd',
                delta: '+18 yd',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _MetricCard(
                icon: Icons.local_fire_department_rounded,
                iconColor: Color(0xFFFF8C42),
                label: 'Practice Streak',
                value: '23 days',
                subtitle: 'Personal best',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    this.delta,
    this.subtitle,
    this.valueColor,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final String? delta;
  final String? subtitle;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: SwingPathColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: SwingPathColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(height: 10),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 12,
                  color: SwingPathColors.textMuted,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: valueColor ?? SwingPathColors.textPrimary,
            ),
          ),
          if (delta != null) ...[
            const SizedBox(height: 4),
            Text(
              delta!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: SwingPathColors.accent,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 11,
                    color: SwingPathColors.textMuted,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}

class _FaultFrequencyCard extends StatelessWidget {
  const _FaultFrequencyCard();

  static const _faults = [
    _FaultItem(
      label: 'Early Extension',
      before: 60,
      after: 24,
      barColor: SwingPathColors.clubSpeed,
    ),
    _FaultItem(
      label: 'Over the Top',
      before: 45,
      after: 12,
      barColor: SwingPathColors.accent,
    ),
    _FaultItem(
      label: 'Casting / Early Release',
      before: 38,
      after: 8,
      barColor: SwingPathColors.accent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: SwingPathColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: SwingPathColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.bar_chart_rounded,
                size: 18,
                color: SwingPathColors.clubSpeed,
              ),
              const SizedBox(width: 8),
              Text(
                'FAULT FREQUENCY',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
          const SizedBox(height: 20),
          for (var i = 0; i < _faults.length; i++) ...[
            if (i > 0) const SizedBox(height: 16),
            _FaultRow(fault: _faults[i]),
          ],
        ],
      ),
    );
  }
}

class _FaultItem {
  const _FaultItem({
    required this.label,
    required this.before,
    required this.after,
    required this.barColor,
  });

  final String label;
  final int before;
  final int after;
  final Color barColor;
}

class _FaultRow extends StatelessWidget {
  const _FaultRow({required this.fault});

  final _FaultItem fault;

  @override
  Widget build(BuildContext context) {
    final progress = fault.after / fault.before;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              fault.label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 14,
                  ),
            ),
            Text(
              '↓ ${fault.before}% → ${fault.after}%',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: SwingPathColors.accent,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: SwingPathColors.border,
            color: fault.barColor,
          ),
        ),
      ],
    );
  }
}

class _Milestone {
  const _Milestone({
    required this.title,
    required this.icon,
    required this.color,
  });

  final String title;
  final IconData icon;
  final Color color;
}

class _MilestonesSection extends StatelessWidget {
  const _MilestonesSection({required this.milestones});

  final List<_Milestone> milestones;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Milestones', style: Theme.of(context).textTheme.titleLarge),
            Text(
              '7 earned',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: SwingPathColors.accent,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 118,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: milestones.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final milestone = milestones[index];
              return _MilestoneBadge(milestone: milestone);
            },
          ),
        ),
      ],
    );
  }
}

class _MilestoneBadge extends StatelessWidget {
  const _MilestoneBadge({required this.milestone});

  final _Milestone milestone;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: SwingPathColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: SwingPathColors.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: milestone.color.withValues(alpha: 0.15),
            ),
            child: Icon(milestone.icon, color: milestone.color, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            milestone.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 10,
                  color: SwingPathColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
