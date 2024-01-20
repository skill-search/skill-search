import 'package:flutter/material.dart';
import 'package:frontend/common/appbar/appbar.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Good day! Ready to seize the day?',
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: Color(0xFFE0E0E0))),
        Text('xxxpussyslayerxxx',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: Color(0xFFFFFFFF)))
      ]),
      actions: [
        //IconButton(onPressed: (){}, icon: const Icon(Icons.search_outlined, color: Color(0xFFFFFFFF)))
      ],
    );
  }
}
