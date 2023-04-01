import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class TaskSwipeCard extends StatefulWidget {
  final List<Task> tasks;
  final Function(Task, bool) onSwipe;

  TaskSwipeCard({required this.tasks, required this.onSwipe});

  @override
  _TaskSwipeCardState createState() => _TaskSwipeCardState();
}

class _TaskSwipeCardState extends State<TaskSwipeCard>
    with TickerProviderStateMixin {
  late CardController _cardController;

  @override
  void initState() {
    super.initState();
    _cardController = CardController();
  }

  @override
  Widget build(BuildContext context) {
    return TinderSwapCard(
      cardController: _cardController,
      orientation: AmassOrientation.BOTTOM,
      totalNum: widget.tasks.length,
      stackNum: 3,
      swipeEdge: 4.0,
      maxWidth: MediaQuery.of(context).size.width * 0.9,
      maxHeight: MediaQuery.of(context).size.width * 0.9,
      minWidth: MediaQuery.of(context).size.width * 0.8,
      minHeight: MediaQuery.of(context).size.width * 0.8,
      cardBuilder: (context, index) => _buildCard(widget.tasks[index]),
      cardSwipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
        bool isSwipeRight = orientation == CardSwipeOrientation.RIGHT;
        widget.onSwipe(widget.tasks[index], isSwipeRight);
      },
    );
  }

  Widget _buildCard(Task task) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(task.title, style: TextStyle(fontSize: 24)),
            SizedBox(height: 16),
            Text(task.description),
          ],
        ),
      ),
    );
  }
}
