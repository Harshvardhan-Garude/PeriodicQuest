import 'package:flutter/material.dart';

import 'package:app/features/quiz/presentation/widgets/quiz_element_card_style.dart';

class PeriodicPuzzleTileWidget extends StatelessWidget {
  const PeriodicPuzzleTileWidget({
    super.key,
    required this.symbol,
    required this.name,
    required this.atomicNumber,
    required this.categoryKey,
    required this.onTap,
    this.categoryLabel,
    this.clueLabel,
    this.isMissing = false,
    this.isFilled = false,
    this.isSelected = false,
    this.showSuccess = false,
  });

  final String symbol;
  final String name;
  final int atomicNumber;
  final String categoryKey;
  final String? categoryLabel;
  final String? clueLabel;
  final VoidCallback? onTap;
  final bool isMissing;
  final bool isFilled;
  final bool isSelected;
  final bool showSuccess;

  @override
  Widget build(BuildContext context) {
    final style = quizElementCardStyleForCategory(categoryKey);
    final isLockedSlot = isMissing && !isFilled;
    final borderColor = isLockedSlot
        ? const Color(0xFF7B9DBA)
        : style.borderColor;
    final gradient = isLockedSlot
        ? const LinearGradient(
            colors: [Color(0xFFF3F8FD), Color(0xFFE1ECF8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : style.gradient;

    return AnimatedScale(
      duration: const Duration(milliseconds: 220),
      scale: isSelected ? 1.03 : 1,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 260),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: isSelected ? const Color(0xFF28567E) : borderColor,
                width: isSelected ? 2.4 : 1.6,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      (showSuccess ? const Color(0xFF44C776) : style.glowColor)
                          .withValues(alpha: 0.24),
                  blurRadius: showSuccess ? 24 : 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: isLockedSlot
                ? _MissingTileFace(clueLabel: clueLabel, isSelected: isSelected)
                : _FilledTileFace(
                    symbol: symbol,
                    name: name,
                    atomicNumber: atomicNumber,
                    categoryLabel: categoryLabel,
                    isFreshlyCompleted: showSuccess,
                  ),
          ),
        ),
      ),
    );
  }
}

class _FilledTileFace extends StatelessWidget {
  const _FilledTileFace({
    required this.symbol,
    required this.name,
    required this.atomicNumber,
    this.categoryLabel,
    required this.isFreshlyCompleted,
  });

  final String symbol;
  final String name;
  final int atomicNumber;
  final String? categoryLabel;
  final bool isFreshlyCompleted;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              '$atomicNumber',
              style: const TextStyle(
                color: Color(0xFF20435E),
                fontSize: 10,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Spacer(),
            if (isFreshlyCompleted)
              const Icon(
                Icons.auto_awesome_rounded,
                size: 14,
                color: Color(0xFF2F9C5C),
              ),
          ],
        ),
        Center(
          child: Text(
            symbol,
            style: const TextStyle(
              color: Color(0xFF17334A),
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFF17334A),
            fontSize: 10.5,
            fontWeight: FontWeight.w800,
          ),
        ),
        if (categoryLabel != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              categoryLabel!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF2B4C67),
                fontSize: 8.5,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
      ],
    );
  }
}

class _MissingTileFace extends StatelessWidget {
  const _MissingTileFace({required this.clueLabel, required this.isSelected});

  final String? clueLabel;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 18,
              height: 18,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.78),
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Icon(
                Icons.touch_app_rounded,
                size: 10,
                color: Color(0xFF45657D),
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(
                Icons.stars_rounded,
                size: 14,
                color: Color(0xFF28567E),
              ),
          ],
        ),
        const Center(
          child: Text(
            '?',
            style: TextStyle(
              color: Color(0xFF28567E),
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.72),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            clueLabel ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF2B4C67),
              fontSize: 8.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}
