$(document).on("turbolinks:load", function () {
  if ($(".pagination").length) {
    $(window).scroll( function() {
      var url = $(".pagination a[rel=next]").attr("href");
      if (url && timeToFetch()) {
        $(".pagination").text("Getting more cards to show...");
        $.getScript(url);
      }
    });

    $(window).scroll();
  }
});

function timeToFetch() {
  return $(document).scrollTop() > $(document).height() -
  $(window).height() - 50;
}
