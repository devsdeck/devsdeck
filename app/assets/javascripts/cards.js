$( document ).on('page:change', function () {
  $(window).scroll( function(){
    url = $(".pagination a[rel=next]").attr("href");
    if (url && buttomYet()){
      $(".pagination").text("Getting more cards to show...");
      $.getScript(url);
    }
  });
});

function buttomYet() {
  return $(document).scrollTop() > $(document).height() - $(window).height() - 50
};
