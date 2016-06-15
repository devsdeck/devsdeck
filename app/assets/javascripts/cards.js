(function(){
    console.log('cards.js');

    $( document ).on("page:change", function () {
        if ($(".pagination").length) {
            $(window).scroll( function() {
                var url = $(".pagination a[rel=next]").attr("href");
                if (url && buttomYet()) {
                    $(".pagination").text("Getting more cards to show...");
                    $.getScript(url);
                }
            });
            $(window).scroll();
        }
    });

    function buttomYet() {
        return $(document).scrollTop() > $(document).height() -
            $(window).height() - 50;
    }

})();

