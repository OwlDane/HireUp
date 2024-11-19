import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class CustomSnackbar {
  static void show({
    required BuildContext context,
    required String message,
    bool isError = false,
    Duration duration = const Duration(seconds: 3),
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isError 
              ? AppColors.error.withOpacity(0.9) 
              : AppColors.success.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isError 
                  ? AppColors.error.withOpacity(0.2) 
                  : AppColors.success.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                isError ? Icons.error_outline : Icons.check_circle_outline,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            // Message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isError ? 'Error' : 'Success',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Close button
            IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      duration: duration,
      margin: const EdgeInsets.all(16),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showSuccess({
    required BuildContext context,
    required String message,
    Duration? duration,
  }) {
    show(
      context: context,
      message: message,
      isError: false,
      duration: duration ?? const Duration(seconds: 3),
    );
  }

  static void showError({
    required BuildContext context,
    required String message,
    Duration? duration,
  }) {
    show(
      context: context,
      message: message,
      isError: true,
      duration: duration ?? const Duration(seconds: 4),
    );
  }
}