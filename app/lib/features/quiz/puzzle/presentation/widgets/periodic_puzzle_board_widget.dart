import 'package:flutter/material.dart';

import 'package:app/features/quiz/models/quiz_language.dart';
import 'package:app/features/quiz/models/quiz_question.dart';
import 'package:app/features/quiz/puzzle/models/periodic_puzzle_board.dart';
import 'package:app/features/quiz/puzzle/models/periodic_puzzle_tile.dart';
import 'package:app/features/quiz/puzzle/presentation/widgets/periodic_puzzle_tile_widget.dart';

class PeriodicPuzzleBoardWidget extends StatelessWidget {
  const PeriodicPuzzleBoardWidget({
    super.key,
    required this.board,
    required this.language,
    required this.filledTileIds,
    required this.selectedTileId,
    required this.onTileTap,
    required this.localizedNameForTile,
    this.completedTileId,
  });

  final PeriodicPuzzleBoard board;
  final QuizLanguage language;
  final Set<String> filledTileIds;
  final String? selectedTileId;
  final String? completedTileId;
  final ValueChanged<PeriodicPuzzleTile> onTileTap;
  final String Function(PeriodicPuzzleTile tile) localizedNameForTile;

  @override
  Widget build(BuildContext context) {
    const tileWidth = 104.0;
    const tileHeight = 128.0;
    final tilesByPosition = <String, PeriodicPuzzleTile>{
      for (final tile in board.tiles) '${tile.row}-${tile.column}': tile,
    };

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: (board.maxColumn + 1) * tileWidth,
        child: Column(
          children: [
            for (var row = 0; row <= board.maxRow; row++) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var column = 0; column <= board.maxColumn; column++)
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: SizedBox(
                        width: tileWidth - 8,
                        height: tileHeight - 8,
                        child: _buildCell(
                          context,
                          tilesByPosition['$row-$column'],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCell(BuildContext context, PeriodicPuzzleTile? tile) {
    if (tile == null) {
      return const SizedBox.shrink();
    }

    final categoryLabel = QuizAnswerOption(
      id: tile.element.sym,
      labelEnglish: tile.element.name,
      labelSpanish: tile.element.name,
      categoryKey: tile.element.cat,
    ).localizedCategory(language);
    final isFilled = !tile.isMissing || filledTileIds.contains(tile.id);

    return PeriodicPuzzleTileWidget(
      symbol: tile.element.sym,
      name: localizedNameForTile(tile),
      atomicNumber: tile.element.z,
      categoryKey: tile.element.cat,
      categoryLabel: categoryLabel,
      clueLabel: tile.clue?.labelFor(language),
      isMissing: tile.isMissing,
      isFilled: isFilled,
      isSelected: selectedTileId == tile.id && tile.isMissing && !isFilled,
      showSuccess: completedTileId == tile.id,
      onTap: tile.isMissing && !isFilled ? () => onTileTap(tile) : null,
    );
  }
}
