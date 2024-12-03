class Constants {
  static const String API_KEY_PAYMOB =
      "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRBd09USTJPQ3dpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS5tRGR3STlyQ3VpVWIxNy1OOGl5dWJVbG9GQXFGbUdJeDJ4MVNtM3BSME55SnF6TUZibXhnZFdmS3Q4QWx2TUhNTEhSVml5UFNxc3k0LW9xX2J3SURvQQ==";
  static const String PUBLIC_KEY =
      "egy_pk_test_AuYuGPLSxcvTS33EF9JNh6Z1vOqyHFUx";

  static final Map<int, int> daysInMonth = {
    1: 31,
    2: DateTime.now().year % 4 == 0 ? 29 : 28,
    3: 31,
    4: 30,
    5: 31,
    6: 30,
    7: 31,
    8: 31,
    9: 30,
    10: 31,
    11: 30,
    12: 31,
  };

  static final Map<int, String> monthDict = {
    1: 'January',
    2: 'February',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'July',
    8: 'August',
    9: 'September',
    10: 'October',
    11: 'November',
    12: 'December',
  };
}
