String convertToString(int num){
  if(num < 1000){
    return num.toString();
  }else if(num > 999 && num < 1000000){
    return "${(num/1000).toStringAsFixed(1)}K";
  }else if(num > 999999 && num < 1000000000){
    return "${(num/1000000).toStringAsFixed(1)}M";
  }else if(num > 999999 && num < 1000000000000){
    return "${(num/1000000000).toStringAsFixed(1)}B";
  }else{
    return "huge";
  }
}