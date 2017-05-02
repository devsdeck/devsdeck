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
  var preview = text ? marked(text) : "Nothing to preview";
  $(".preview").html(preview);
}
