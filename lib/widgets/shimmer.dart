import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class Shimmerpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color.fromARGB(255, 230, 230, 230),
      highlightColor: Color.fromARGB(255, 255, 255, 255),
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    color: Colors.grey,
                    width: 60,
                    height: 25,
                  ),
                ],
              ),
            ),
            SizedBox(
              child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        color: Colors.red,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        height: 166,
                        width: 160,
                      ),
                      Container(
                        color: Colors.grey,
                        height: 15,
                        width: 50,
                      ),
                      SizedBox(height: 5),
                      Container(
                        color: Colors.grey,
                        height: 15,
                        width: 50,
                      ),
                    ],
                  );
                },
              ),
              height: 240,
            )
          ]);
        },
      ),
    ); /*Shimmer.fromColors(
        baseColor: Color.fromARGB(255, 146, 146, 146),
        highlightColor: Color.fromARGB(255, 201, 201, 201),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemCount: 100,
          itemBuilder: (BuildContext context, int index) {
            return Column(children: [
              Container(width: 60, height: 10),
              SizedBox(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          height: 166,
                          width: 160,
                        ),
                        const Text(
                          '    ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const Text(
                          '   ',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )
                      ],
                    );
                  },
                ),
                height: 240,
              )
            ]);
          },
        ));*/
  }
}
