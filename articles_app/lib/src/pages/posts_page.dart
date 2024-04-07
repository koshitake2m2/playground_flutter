import 'package:articles_app/src/database/database_di.dart';
import 'package:articles_app/src/database/migration.dart';
import 'package:articles_app/src/utils/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsPage extends ConsumerStatefulWidget {
  const PostsPage({super.key});

  @override
  ConsumerState<PostsPage> createState() => _PostsPage();
}

class _PostsPage extends ConsumerState<PostsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final postsDao = ref.read(postsDaoProvider);
    final db = ref.read(databaseProvider);
    db.into(db.posts).insert(PostsCompanion.insert(title: 'Hello'));

    return Scaffold(
      appBar: AppBar(title: const Text('Posts Page')),
      body: StreamBuilder<List<Post>>(
        stream: postsDao.getAllStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            // Handle error
            Log.info(snapshot.error.toString());
            return const Center(child: Text('An error occurred!'));
          } else {
            final posts = snapshot.data ?? [];
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  title: Text('Post ${post.id}'),
                  subtitle: Text(post.title),
                );
              },
            );
          }
        },
      ),
    );
  }
}
