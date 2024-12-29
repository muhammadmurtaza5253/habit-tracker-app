import 'package:flutter/material.dart';
import 'package:habit_tracker_app/utils/app_colors.dart';

class UnPaidPageActions extends StatelessWidget {
  final bool isDeleting;
  final Future<void> Function(BuildContext context) deleteHabit;
  final VoidCallback onOkPressed;

  const UnPaidPageActions({
    Key? key,
    required this.isDeleting,
    required this.deleteHabit,
    required this.onOkPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          widthFactor: 0.4,
          child: IconButton(
            icon: isDeleting
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.error),
                    ),
                  )
                : const Icon(Icons.delete, color: AppColors.error),
            onPressed: isDeleting
                ? null
                : () async {
                    await deleteHabit(context);
                  },
          ),
        ),
        Align(
          widthFactor: 0.5,
          child: TextButton(
            child: const Text(
              'OK',
              style: TextStyle(color: AppColors.secondary),
            ),
            onPressed: onOkPressed,
          ),
        ),
      ],
    );
  }
}
