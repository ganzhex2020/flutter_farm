
import 'package:flutter/material.dart';
import 'package:flutter_farm/common/Constant.dart';


class LoadingContainer extends StatelessWidget{

  final Widget child;
  final bool loading;
  final bool error;
  final VoidCallback retry;


  const LoadingContainer(
      {Key key,
        @required this.loading,
        @required this.child,
        this.error = false,
        this.retry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !loading ? error ? _errorView : child : _loadView;
  }

  Widget get _errorView {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images/ic_error.png',
            width: 100,
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              Constant.net_error_tip,
              style: TextStyle(color: Constant.hitTextColor, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: OutlineButton(
              onPressed: () => retry.call(),
              child: Text(Constant.reload_again),
              highlightColor: Colors.white,
              highlightedBorderColor: Colors.black12,
            ),
          )
        ],
      ),
    );
  }

  Widget get _loadView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}