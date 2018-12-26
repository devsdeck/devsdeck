$(document).on("turbolinks:load", function () {
  addCopyButton();
});

function addCopyButton() {
  new Clipboard('.clipboard-copy');

  $("pre").each(function(index) {
    var id = "id_" + index;
    var $this = $(this)
    $this.children("code").attr("id", id);
    prependButton($this, id);
  });
}

function prependButton($pre, id) {
  if ($pre.find(".clipboard-copy").length === 0) {
    var button = $("<div class='ui compact small basic icon buttons right floated'>" +
      "<button class='mini ui button clipboard-copy' data-clipboard-target=#" + id + ">" +
      "<i class='clipboard icon'></i>" +
      "</button>" +
      "</div>");
    $pre.children("code").prepend(button);
  }
}
