$(document).on("turbolinks:load", function () {
  addCopyButton();
});

function addCopyButton() {
  new Clipboard('.clipboard-copy');

  $("pre").each(function(index) {
    var id = "id_" + index;
    $(this).children("code").attr("id", id);
    prependButtonAndHide($(this), id);
    toggleCopyButton($(this));
  });
}

function prependButtonAndHide(pre, id) {
  if (pre.find(".clipboard-copy").length == 0) {
    var button = $("<div class='ui small basic icon buttons right floated'>" +
      "<button class='mini ui button clipboard-copy' data-clipboard-target=#" + id + ">" +
      "<i class='clipboard icon'></i>" +
      "</button>" +
      "</div>");
    pre.children("code").prepend(button);
    pre.find(".clipboard-copy").hide();
  }
}

function toggleCopyButton(pre) {
  pre.on("mouseenter", function() {
    pre.find(".clipboard-copy").show();
  });

  pre.on("mouseleave", function() {
    pre.find(".clipboard-copy").hide();
  });
}

