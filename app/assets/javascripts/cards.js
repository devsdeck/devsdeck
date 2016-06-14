(function(){
    console.log('cards.js');

    $(document).ready(function(){
        console.log('Set click handlers');

        $('a.ui.tag.label').on('click', search_by_tag);
    });

    function search_by_tag(data){
        console.log('Tag clicked: ', data.target.innerText);
        pass_text_to_search_field(data.target.innerText);
        submit_form('card_search');
    }

    function pass_text_to_search_field(text){
        $('#q_name_cont')[0].value = text;
    }

    function submit_form(id){
        $('#'+id)[0].submit();
    }

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

