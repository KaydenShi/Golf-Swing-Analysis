import 'package:flutter/material.dart';
import 'package:golf_swing_analysis/theme/swingpath_theme.dart';
import 'package:image_picker/image_picker.dart';

void showRecordOptionsSheet(BuildContext context) {
  final ImagePicker picker = ImagePicker();

  Future<void> pickVideo(ImageSource source) async {
    try {
      final XFile? video = await picker.pickVideo(
        source: source,
        maxDuration: const Duration(minutes: 5),
      );
      
      if (video != null && context.mounted) {
        // Here you would navigate to the analysis screen with the video path
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Video captured: ${video.name}'),
            backgroundColor: SwingPathColors.accent,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  showModalBottomSheet(
    context: context,
    backgroundColor: SwingPathColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: SwingPathColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Record a Swing',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Capture your swing for AI analysis',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: SwingPathColors.accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.videocam_rounded, color: SwingPathColors.accent),
              ),
              title: const Text('Record Video'),
              subtitle: const Text('Use camera for live analysis'),
              onTap: () {
                Navigator.pop(context);
                pickVideo(ImageSource.camera);
              },
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: SwingPathColors.swings.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.photo_library_rounded, color: SwingPathColors.swings),
              ),
              title: const Text('Choose from Gallery'),
              subtitle: const Text('Upload a pre-recorded swing'),
              onTap: () {
                Navigator.pop(context);
                pickVideo(ImageSource.gallery);
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    ),
  );
}
