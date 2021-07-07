$(function () {
    $(".tweet-show__content__like--link").on("click", function () {
      $(".tweet-show__content__like--bgc").fadeToggle();
    });
    $(".tweet-show__content__like--close").click(function () {
      $(".tweet-show__content__like--bgc").fadeToggle();
    });
});