$(document).on("turbolinks:load", function () {
  highlight();
});

function highlight() {
  $('pre code').each(function(i, block) {
    hljs.highlightBlock(block);
  });
}
