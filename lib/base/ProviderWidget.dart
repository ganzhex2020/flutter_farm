import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//状态管理组件封装(MVVM),核心组件(基于provider封装)
//provider状态管理，可以比喻成电台与听众的关系，电台 --》ChangeNotifierProvider 听众 --》Consumer  model -->维护了一系列状态数据

class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget child) builder;
  final T viewModel;
  final Widget child;
  final Function(T) onModelInit;//数据初始化方法

  ProviderWidget(
      {Key key,
        @required this.viewModel,
        @required this.builder,
        this.onModelInit,
        this.child})
      : super(key: key);

  @override
  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();

}

class _BaseWidgetState<T extends ChangeNotifier> extends State<ProviderWidget<T>> {
  T viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;
    if (widget.onModelInit != null && viewModel != null) {
      widget.onModelInit(viewModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(_)=> viewModel,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );//可以控制刷新性能优化，当数据数据发生改变，不会重新build
  }
}
