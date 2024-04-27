import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:multi_task_app/pages/religion/duas/duas_provider.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DuasProvider>(context);
    final duas = provider.duas;
    return Scaffold(
      backgroundColor: const Color(0xfff3dbcc),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: ListView.builder(
              itemCount: duas.length,
              itemBuilder: (context, index) {
                final dua = duas[index];
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(
                          dua,
                          style:const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xffa96054),
                          ),
                        ),
                        trailing: IconButton(
                          icon: provider.isExist(dua)
                              ?const Icon(
                                  Icons.favorite,
                                  color: Color(0xffa96054),
                                )
                              :const Icon(
                                  Icons.favorite_border,
                                  color: Color(0xffa96054),
                                ),
                          onPressed: () {
                            provider.addDuas(dua);
                          },
                        ),
                      ),
                    ),
                   const Divider(
                      color: Color(0xffa96054),
                    )
                  ],
                );
              },
            ),
          ),
          const Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'fav',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xffa96054),
                      fontSize: 30),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Icon(
                    Icons.favorite,
                    color: Color(0xffa96054),
                    size: 20,
                  ),
                ),
                Text(
                  'urite',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xffa96054),
                      fontSize: 30),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xffa96054),
            ),
          ).animate().fade(delay: .2.seconds, duration: .3.seconds),
        ],
      ),
    );
  }
}
