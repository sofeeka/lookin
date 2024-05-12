class Logger{

  static bool logging = false;
  static log(String s)
  {
    if(logging) {
      print(s);
    }
  }
}