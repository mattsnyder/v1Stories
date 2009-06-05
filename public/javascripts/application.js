// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript");}
});

jQuery.fn.displayDropdown = function(){
    this.change(function() {
        $("#project_name").val($("#project :selected").text());
        $.post("iterations", $("#show_iteration_form").serialize(), null, "script");
        return false;
    })
}

jQuery.fn.popUp = function(){
    this.submit(function() {
        var left = (screen.width/2)-(650/2);
        var top = (screen.height/2)-(600/2);
        window.open('', 'print_stories', 'width=650,height=600,top='+top+',left='+left+',status=yes,resizable=yes,scrollbars=yes');
    })
}

$(document).ready(function() {
    $("#project").displayDropdown();
    $("#show_stories_form").popUp();
    $("#show_iteration_form").popUp();
})