String formatDistanceToNowStrict(String dateString) {
  DateTime now = DateTime.now();
  DateTime date = DateTime.parse(dateString);
  Duration difference = now.difference(date);
  if (difference.inSeconds < 60) {
    int seconds = difference.inSeconds;
    if(difference.inSeconds.isNegative){
      return '0 seconds';
    }else{
      return '$seconds seconds';
    }
  } else if (difference.inMinutes < 60) {
    int minutes = difference.inMinutes;
    return '$minutes minutes';
  } else if (difference.inHours < 24) {
    int hours = difference.inHours;
    return '$hours hours';
  } else if (difference.inDays < 30) {
    int days = difference.inDays;
    return '$days days';
  } else if (difference.inDays < 365) {
    int months = difference.inDays ~/ 30;
    return '$months months';
  } else {
    int years = difference.inDays ~/ 365;
    return '$years years';
  }
}