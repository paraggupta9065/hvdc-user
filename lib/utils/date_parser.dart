String dateParser(DateTime dateTime) {
  String textDate = '';
  textDate += '${months[dateTime.month]} ';
  textDate += '${dateTime.day}, ';
  textDate += '${dateTime.year}';
  return textDate;
}

List<String> months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];
