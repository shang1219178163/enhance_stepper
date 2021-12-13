//
//  ddlog.dart
//  ddlog
//
//  Created by shang on 7/4/21 3:53 PM.
//  Copyright © 7/4/21 shang. All rights reserved.
//

import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform;
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names, unnecessary_question_mark
void ddlog(dynamic? obj) {
  DDTraceModel model = DDTraceModel(StackTrace.current);

  var list = [
    DateTime.now().toString(),
    model.fileName,
    model.className,
    model.selectorName,
    model.lineNumber == "" ? "" : "[${model.lineNumber}:${model.columnNumber}]"
  ].where((element) => element != "");
  print("${list.join(" ")}: $obj");
}

/// TraceModel
class DDTraceModel {
  final StackTrace _trace;

  String fileName = "";
  String className = "";
  String selectorName = "";
  String lineNumber = "";
  String columnNumber = "";

  DDTraceModel(this._trace) {
    _parseTrace();
  }

  /// parse trace
  void _parseTrace() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        {
          var traceString2 = _trace.toString().split("\n")[2];

          List<String> list = traceString2
              .split(" ")
              .where((element) => element != "")
              .toList();
          // this.selectorName = list.last.replaceAll("[", "").replaceAll("]", "()").trim();
          this.selectorName = list[1];

          var nameAndLines = list.last.split("/").last.split(".dart:");
          this.className = nameAndLines.first + ".dart";
          _parseLineAndcolumn(location: nameAndLines.last);
        }
        break;
      default:
        {
          var traceString1 = this._trace.toString().split("\n")[1];

          List<String> list = traceString1
              .replaceAll("#1", "")
              .replaceAll(".<anonymous closure>", "")
              .replaceAll(")", "")
              .replaceAll("(", "")
              .replaceAll(".dart:", ".dart ")
              .split(" ")
              .where((element) => element != "")
              .toList();

          var fileInfo = list.first.split(".").toList();
          this.className = fileInfo.first;
          this.selectorName = fileInfo.last + "()";

          _parseClassName(path: list[1]);
          _parseLineAndcolumn(location: list.last);
        }
        break;
    }
  }

  /// parse className
  void _parseClassName({required String path}) {
    if (path.contains("/")) {
      List<String> list = path
          .split("/")
          .last
          .split(" ")
          .where((element) => element != "")
          .toList();
      this.fileName = list.first.trim();
    }
  }

  /// parse Line and column
  void _parseLineAndcolumn({required String location}) {
    if (location.contains(":")) {
      List<String> list = location.split(":");
      this.lineNumber = list.first.trim();
      this.columnNumber = list.last.trim().replaceAll(")", "");
    }
  }
}
