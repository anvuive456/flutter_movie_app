import 'package:intl/intl.dart';
abstract final class AppStrings {
  static const String labelExpandText = 'show more';
  static const String labelMovieDescription ='Plot';

  static const String labelMovieGenre='Genres';
  static const String labelContentRating='Content rating';

  static const String labelMovieActors='Actors';

  static const String labelMovieRatings='Ratings';

  static const String labelMovies='Movies';

  static const String labelAvgMovieRating='Average';

  static const String messageSavedToWishlist='Saved to wish list';
  static const String messageRemovedToWishlist='Removed from wish list';

  static const String labelSignUp = 'Sign up now';

  static const String labelSignIn='Sign in';

  static const String titleAppName='Movies App';

  static const String labelMyWishlist='My wish list';

  static const String labelMyInformation='My information';

  static const String AVATAR_HERO_TAG='AVATAR_HERO';

  static const String labelSignOut = 'Sign out';

  static const String errUserNotFoundOrHaveNotSignedUp ='User not found or you have not signed up';
  static  String labelMyWishlistWithCount(int count)=>'My wish list ($count)';


  //Error messages
  static  String errInvalidLength(int length) => 'You must enter at least $length characters';
  static  String errInvalidMatch(String firstField, String secondField) => 'your ${firstField.replaceAll('_', ' ')} must match ${secondField.replaceAll('_', ' ')}';
  static const String errInvalidEmail = 'You must enter an valid email. Eg: john@smith.com';
  static const String errInvalidRequired='This field cannot be empty';

  static String textReleaseDate(String releaseDate) {
    final parsedDate = DateFormat('yyyy-MM-dd').tryParse(releaseDate);
    if(parsedDate == null) return '';
    return 'Release date: ${DateFormat('dd MMM,yyyy').format(parsedDate)}';
  }

}