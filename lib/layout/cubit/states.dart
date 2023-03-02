// ignore_for_file: camel_case_types

abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialChangeBottomNavState extends SocialStates {}

//-----------------------------------------------------------------------------
class SocialLoadingHomeDataState extends SocialStates {}

class SocialSuccessHomeDataState extends SocialStates {}

class SocialErrorHomeDataState extends SocialStates {}

//-------------------------------------------------------------
class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;
  SocialGetUserErrorState(this.error);
}

//____________________________________________________________
class SearchForUserLoadingState extends SocialStates {}

class SearchForUserSuccessState extends SocialStates {}

class SearchForUserErrorState extends SocialStates {}

class GetLikesLoadingState extends SocialStates {}

//____________________________________________________________
class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates {
  final String error;
  SocialGetPostsErrorState(this.error);
}

class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {
  final String error;
  SocialLikePostErrorState(this.error);
}

class SocialUnlikePostSuccessState extends SocialStates {}

class SocialUnlikePostErrorState extends SocialStates {
  final String error;
  SocialUnlikePostErrorState(this.error);
}

class SocialRemovePostSuccessState extends SocialStates {}

class SocialRemovePostErrorState extends SocialStates {}

//_____________________________________________________________
class SocialNewPostState extends SocialStates {}

class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialCoverImagePickedSuccessState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}

//_____________________________________________________________
class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

//_____________________________________________________________
class SocialUserUpdateLoadingState extends SocialStates {}

class SocialUserUpdateSuccessState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}

//_____________________________________________________________
class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

//_____________________________________________________________
class SocialPostImagePickedSuccessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

//_____________________________________________________________
class SocialCreateCommentLoadingState extends SocialStates {}

class SocialCreateCommentSuccessState extends SocialStates {}

class SocialCreateCommentErrorState extends SocialStates {}

//_____________________________________________________________
class SocialCreateRateSuccessState extends SocialStates {}

class SocialCreateRateErrorState extends SocialStates {}

class SocialGetRateSuccessState extends SocialStates {}

class SocialGetRateErrorState extends SocialStates {
  final String error;
  SocialGetRateErrorState(this.error);
}
//_____________________________________________________________

class SocialUploadCommentImageLoadingStates extends SocialStates {}

class SocialUploadCommentImageSuccessStates extends SocialStates {}

class SocialUploadCommentImageErrorStates extends SocialStates {}

//_____________________________________________________________
class SocialCommentImagePickedSuccessState extends SocialStates {}

class SocialCommentImagePickedErrorState extends SocialStates {}

class SocialRemoveCommentImageState extends SocialStates {}

//_____________________________________________________________
class SocialGetCommentsLoadingState extends SocialStates {}

class SocialGetCommentsSuccessState extends SocialStates {}

class SocialGetCommentsErrorState extends SocialStates {
  final String error;
  SocialGetCommentsErrorState(this.error);
}

//______________________________________________________________
class SocialLikeCommentSuccessState extends SocialStates {}

class SocialLikeCommentErrorState extends SocialStates {
  final String error;
  SocialLikeCommentErrorState(this.error);
}

//_______________________________________________________
class SocialUserSignOutSuccessState extends SocialStates {}

class SocialUserSignOutErrorState extends SocialStates {}

//________________________________________________________
class SocialGetAllUsersLoadingState extends SocialStates {}

class SocialGetAllUsersSuccessState extends SocialStates {}

class SocialGetAllUsersErrorState extends SocialStates {
  final String error;
  SocialGetAllUsersErrorState(this.error);
}

//_________________________________________________________________
class SocialSendMessageLoadingState extends SocialStates {}

class SocialSendMessageSuccessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates {
  final String error;
  SocialSendMessageErrorState(this.error);
}

class SocialGetMessageSuccessState extends SocialStates {}

class SocialGetMessageLoginState extends SocialStates {}

class SocialGetUserPostsLengthSuccessState extends SocialStates {}

class SocialGetUserPostsLengthLoadingState extends SocialStates {}

class SocialGetUserPostsLengthErrorState extends SocialStates {}

//______________________________________________________________________
class SocialAddToFollowersSuccessState extends SocialStates {}

class SocialAddToFollowersLoadingState extends SocialStates {}

class SocialAddToFollowersErrorState extends SocialStates {}

class SocialGetUserFollowersLengthSuccessState extends SocialStates {}

class SocialGetUserFollowersLengthLoadingState extends SocialStates {}

class SocialGetUserFollowersLengthErrorState extends SocialStates {}

//_____________________________________________________________
class SocialAddToFavoritesSuccessState extends SocialStates {}

class SocialAddToFavoritesLoadingState extends SocialStates {}

class SocialAddToFavoritesErrorState extends SocialStates {}

class SocialGetFavoritesSuccessState extends SocialStates {}

class SocialGetFavoritesLoadingState extends SocialStates {}

class SocialGetFavoritesErrorState extends SocialStates {}

class SocialRemoveFromFavoritesSuccessState extends SocialStates {}

class SocialRemoveFromFavoritesLoadingState extends SocialStates {}

class SocialRemoveFromFavoritesErrorState extends SocialStates {}

//____________________________________________________________
class SocialAddToWatchLaterSuccessState extends SocialStates {}

class SocialAddToWatchLaterLoadingState extends SocialStates {}

class SocialAddToWatchLaterErrorState extends SocialStates {}

class SocialGetWatchLaterSuccessState extends SocialStates {}

class SocialGetWatchLaterLoadingState extends SocialStates {}

class SocialGetWatchLaterErrorState extends SocialStates {}

//---------------------------------------------------------
class StoryImageChosenSuccessState extends SocialStates {}

class StoryImageChosenErrorState extends SocialStates {}

class CreateStorySuccessState extends SocialStates {}

class CreateStoryLoadingState extends SocialStates {}

class CanceledImageForStoryState extends SocialStates {}

class GetArchivedStoriesLoadingState extends SocialStates {}

class GetArchivedStoriesSuccessState extends SocialStates {}
