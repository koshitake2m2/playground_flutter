import 'package:articles_app/src/database/database_di.dart';
import 'package:articles_app/src/database/migration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsAddModal extends ConsumerStatefulWidget {
  const PostsAddModal({super.key});

  @override
  ConsumerState<PostsAddModal> createState() => _PostsAddModal();
}

class _PostsAddModal extends ConsumerState<PostsAddModal> {
  final TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final postsDao = ref.read(postsDaoProvider);
    onPressedAdd() {
      postsDao.create(titleController.text);
      Navigator.pop(context);
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Add Post'),
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'title'),
          ),
          ElevatedButton(
            onPressed: () {
              onPressedAdd();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
