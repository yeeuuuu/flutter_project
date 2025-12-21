// import 'package:flutter/material.dart';
// import '../../models/types.dart';
// import '../../theme/app_theme.dart';

// class TaskItem extends StatelessWidget {
//   final Task task;
//   final ValueChanged<bool?> onToggle;

//   const TaskItem({super.key, required this.task, required this.onToggle});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 8),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         border: Border.all(color: AppTheme.border),
//         borderRadius: BorderRadius.circular(AppTheme.radius),
//       ),
//       child: Row(
//         children: [
//           // Checkbox
//           Transform.scale(
//             scale: 1.1,
//             child: Checkbox(
//               value: task.completed,
//               onChanged: onToggle,
//               activeColor: AppTheme.primary,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(4),
//               ),
//               side: const BorderSide(color: AppTheme.mutedForeground),
//             ),
//           ),
//           const SizedBox(width: 8),

//           // Title & Priority
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   task.title,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     decoration: task.completed
//                         ? TextDecoration.lineThrough
//                         : null,
//                     color: task.completed
//                         ? AppTheme.mutedForeground
//                         : AppTheme.foreground,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Badge (Category)
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//             decoration: BoxDecoration(
//               color: AppTheme.muted,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Text(
//               task.category.name.toUpperCase(),
//               style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
