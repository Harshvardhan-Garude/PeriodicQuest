import 'package:flutter/material.dart';

import 'package:app/core/router/app_navigation.dart';
import 'package:app/features/quiz/data/quiz_leaderboard_repository.dart';
import 'package:app/features/quiz/data/quiz_question_generator.dart';
import 'package:app/features/quiz/models/quiz_language.dart';
import 'package:app/features/quiz/models/quiz_mode_type.dart';
import 'package:app/features/quiz/presentation/quiz_game_page.dart';
import 'package:app/features/quiz/puzzle/presentation/periodic_puzzle_home_page.dart';
import 'package:app/features/quiz/puzzle/models/periodic_puzzle_strings.dart';
import 'package:app/features/quiz/presentation/widgets/quiz_language_toggle.dart';
import 'package:app/features/quiz/presentation/widgets/quiz_mode_card.dart';
import 'package:app/shared/decorations/app_gradients.dart';
import 'package:app/shared/widgets/pill_back_button.dart';

class QuizHomePage extends StatefulWidget {
  const QuizHomePage({
    super.key,
    this.questionGenerator = const QuizQuestionGenerator(),
    this.leaderboardRepository,
    this.initialLanguage = QuizLanguage.english,
    this.randomSeed,
  });

  final QuizQuestionGenerator questionGenerator;
  final QuizLeaderboardRepository? leaderboardRepository;
  final QuizLanguage initialLanguage;
  final int? randomSeed;

  @override
  State<QuizHomePage> createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  late QuizLanguage _selectedLanguage;

  QuizLeaderboardRepository get _leaderboardRepository =>
      widget.leaderboardRepository ?? QuizLeaderboardRepository.instance;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = widget.initialLanguage;
  }

  @override
  Widget build(BuildContext context) {
    final strings = QuizStrings.of(_selectedLanguage);
    final puzzleStrings = PeriodicPuzzleStrings.of(_selectedLanguage);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppGradients.skyBlue),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final contentWidth = constraints.maxWidth
                  .clamp(320.0, 860.0)
                  .toDouble();
              return Center(
                child: SizedBox(
                  width: contentWidth,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PillBackButton(
                              contentWidth: contentWidth,
                              foreground: const Color(0xFF3D6B80),
                              label: strings.backToGameModesLabel,
                            ),
                            const Spacer(),
                            QuizLanguageToggle(
                              selectedLanguage: _selectedLanguage,
                              onChanged: (value) {
                                setState(() {
                                  _selectedLanguage = value;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFFF0A4), Color(0xFFFFC7E7)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(
                              color: const Color(0xFFFFC97A),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFFFFB84D,
                                ).withValues(alpha: 0.28),
                                blurRadius: 26,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  strings.quizCollectionLabel,
                                  style: textTheme.labelLarge?.copyWith(
                                    color: const Color(0xFF7E4B1F),
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '🧪',
                                    style: TextStyle(fontSize: 42),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          strings.quizModeTitle,
                                          style: textTheme.displaySmall
                                              ?.copyWith(
                                                color: const Color(0xFF1A3A5C),
                                                fontWeight: FontWeight.w900,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                strings.chooseQuizStyleLabel,
                                style: textTheme.titleMedium?.copyWith(
                                  color: const Color(0xFF45657D),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 22),
                        QuizModeCard(
                          title: strings.quickQuizTitle,
                          heroLabel: strings.quizReadyLabel,
                          badges: [
                            strings.quickQuizQuestionCount,
                            strings.instantFeedbackBadge,
                          ],
                          emoji: '⚡',
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFFD45A), Color(0xFFFFA66E)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderColor: const Color(0xFFD8A300),
                          glowColor: const Color(0xFFFFC54D),
                          lines: [
                            strings.quickQuizDescription,
                            strings.quickHintSummary,
                            strings.answerChoicesLabel,
                          ],
                          onTap: () => _openQuizMode(QuizModeType.quick),
                        ),
                        const SizedBox(height: 18),
                        QuizModeCard(
                          title: strings.challengeModeTitle,
                          heroLabel: strings.quizReadyLabel,
                          badges: [
                            strings.challengeQuizQuestionCount,
                            strings.challengeHintsSummary,
                            strings.finalResultsBadge,
                          ],
                          emoji: '🏆',
                          gradient: const LinearGradient(
                            colors: [Color(0xFFDCC8FF), Color(0xFFA7D8FF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderColor: const Color(0xFF9E78DA),
                          glowColor: const Color(0xFF9E78DA),
                          lines: [
                            strings.challengeResultsTiming,
                            strings.challengeHintsSummary,
                            strings.answerChoicesLabel,
                          ],
                          onTap: () => _openQuizMode(QuizModeType.challenge),
                        ),
                        const SizedBox(height: 18),
                        QuizModeCard(
                          title: puzzleStrings.puzzleTitle,
                          heroLabel: puzzleStrings.puzzleSubtitle,
                          badges: [
                            puzzleStrings.layerBadgeOne,
                            puzzleStrings.layerBadgeTwo,
                            puzzleStrings.layerBadgeThree,
                          ],
                          emoji: '🧩',
                          gradient: const LinearGradient(
                            colors: [Color(0xFFCFF4FF), Color(0xFFFFD6F0)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderColor: const Color(0xFF73BDE2),
                          glowColor: const Color(0xFF8CCBFF),
                          lines: [
                            puzzleStrings.puzzleSubtitle,
                            puzzleStrings.groupLabel(
                              'Tap missing tiles to learn the table',
                              'Toca casillas faltantes para aprender la tabla',
                            ),
                            puzzleStrings.groupLabel(
                              'Names, symbols, and real-world clues',
                              'Nombres, símbolos y pistas del mundo real',
                            ),
                          ],
                          onTap: _openPuzzleMode,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _openQuizMode(QuizModeType mode) async {
    final returnedLanguage = await Navigator.push<QuizLanguage>(
      context,
      slideRoute(
        QuizGamePage(
          mode: mode,
          initialLanguage: _selectedLanguage,
          questionGenerator: widget.questionGenerator,
          leaderboardRepository: _leaderboardRepository,
          randomSeed: widget.randomSeed,
        ),
      ),
    );

    if (returnedLanguage != null && mounted) {
      setState(() {
        _selectedLanguage = returnedLanguage;
      });
    }
  }

  Future<void> _openPuzzleMode() async {
    final returnedLanguage = await Navigator.push<QuizLanguage>(
      context,
      slideRoute(PeriodicPuzzleHomePage(initialLanguage: _selectedLanguage)),
    );

    if (returnedLanguage != null && mounted) {
      setState(() {
        _selectedLanguage = returnedLanguage;
      });
    }
  }
}
