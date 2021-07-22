//⚠️ 自定义 日志打印方法

// ignore: non_constant_identifier_names, unnecessary_question_mark
void ddlog(dynamic? obj){
  DDTraceModel model = DDTraceModel(StackTrace.current);
  print("${DateTime.now()}  ${model.fileName}, ${model.className} [line ${model.lineNumber}]: $obj");
}

class DDTraceModel {
  final StackTrace _trace;

  String fileName = "";
  String className = "";
  int lineNumber = 0;
  int columnNumber = 0;

  DDTraceModel(this._trace) {
    _parseTrace();
  }

  void _parseTrace() {
    var traceString = this._trace.toString().split("\n")[1];
    this.className = traceString.split(".")[0].replaceAll("#1", "").trim();
    // print('___${this.className}_$traceString');
    // print('___${this.className}_\n${this._trace.toString()}');

    var indexOfFileName = traceString.indexOf(RegExp(r'[A-Za-z_]+.dart'));
    var fileInfo = traceString.substring(indexOfFileName);
    var listOfInfos = fileInfo.split(":");
    this.fileName = listOfInfos[0];
    this.lineNumber = int.parse(listOfInfos[1]);

    var columnStr = listOfInfos[2];
    columnStr = columnStr.replaceFirst(")", "");
    this.columnNumber = int.parse(columnStr);
  }
}