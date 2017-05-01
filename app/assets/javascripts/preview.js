$(document).on("turbolinks:load", function () {
  $("#card-preview").click(function(){
    previewCard();
    highlight();
  });
});

function previewCard() {
  marked.setOptions({
    renderer: new marked.Renderer(),
    gfm: true,
    tables: true,
    breaks: true,
    pedantic: false,
    sanitize: false,
    smartLists: true,
    smartypants: false
  });

  var text = $("#card-description").val();
  if ( text )
    $(".preview").html(marked(text))
  else
    $(".preview").html("Nothing to preview...");
}
