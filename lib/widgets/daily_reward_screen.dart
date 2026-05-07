import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/rewards_service.dart';

class DailyRewardScreen extends StatefulWidget {
  final int day;
  final int reward;
  final Color primaryColor;
  const DailyRewardScreen({
    super.key,
    required this.day,
    required this.reward,
    required this.primaryColor,
  });

  @override
  State<DailyRewardScreen> createState() => _DailyRewardScreenState();
}

class _DailyRewardScreenState extends State<DailyRewardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))..forward();
    HapticFeedback.heavyImpact();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A0033),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: Tween(begin: 0.6, end: 1.0).animate(
                    CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut),
                  ),
                  child: const Text('🎁', style: TextStyle(fontSize: 90)),
                ),
                const SizedBox(height: 16),
                ShaderMask(
                  shaderCallback: (r) => LinearGradient(
                    colors: [widget.primaryColor, const Color(0xFFFFD740)],
                  ).createShader(r),
                  child: const Text('BONUS ZILNIC',
                      style: TextStyle(
                          fontSize: 26, fontWeight: FontWeight.w900,
                          color: Colors.white, letterSpacing: 4)),
                ),
                const SizedBox(height: 4),
                Text('Ziua ${widget.day} / 7',
                    style: const TextStyle(color: Colors.white60, fontSize: 16)),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: widget.primaryColor, width: 2),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.monetization_on,
                          color: Color(0xFFFFD740), size: 44),
                      const SizedBox(width: 10),
                      Text('+${widget.reward}',
                          style: const TextStyle(
                              fontSize: 44, fontWeight: FontWeight.w900,
                              color: Color(0xFFFFD740))),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 6,
                  runSpacing: 6,
                  children: List.generate(7, (i) {
                    final day = i + 1;
                    final claimed = day <= widget.day;
                    final isToday = day == widget.day;
                    return Container(
                      width: 44, height: 70,
                      decoration: BoxDecoration(
                        color: isToday
                            ? widget.primaryColor.withValues(alpha: 0.4)
                            : (claimed ? Colors.green.withValues(alpha: 0.3) : Colors.white12),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isToday ? widget.primaryColor : Colors.white24,
                          width: isToday ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Z$day',
                              style: TextStyle(
                                  color: claimed ? Colors.white : Colors.white60,
                                  fontSize: 10)),
                          const SizedBox(height: 2),
                          if (claimed)
                            const Icon(Icons.check, color: Colors.white, size: 14)
                          else
                            const Icon(Icons.monetization_on,
                                color: Color(0xFFFFD740), size: 14),
                          Text('${RewardsService.dailyRewards[i]}',
                              style: TextStyle(
                                  color: claimed ? Colors.white : Colors.white60,
                                  fontSize: 10, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 28),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('PRIMEȘTE'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
