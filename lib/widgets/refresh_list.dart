import 'package:flutter/material.dart';

Widget refreshList(Future<void> Function() onRefresh, List<Widget> children) {
    return RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: children,
        ),
    );
}
