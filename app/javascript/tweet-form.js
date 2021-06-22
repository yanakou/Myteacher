$(function () {

  $("#md-textarea").keyup(function () {
    $("#tweet-text-count").text($(this).val().length + '/1000');
  });

  if (document.location.href.match(/\/tweets\/\d+\/edit/)) {
    $("#tweet-text-count").text($("#md-textarea").val().length + '/1000');
  }

  $("#tweet-form").submit(function () {
    if ($("#md-textarea").val().length > 1000) {
      alert('本文を1,000文字以内で入力してください。');
      return false;
    }
  });

  // 実装予定のタグ検索機能です！
  // $("#tag-submit").on("click", function () {
  //   let input = $("#tag-input").val();
  //   window.location.href = `http://localhost:3000/tweets?tag_name=${input}`
  // });

});