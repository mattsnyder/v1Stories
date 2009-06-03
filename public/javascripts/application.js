// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript");}
});

jQuery.fn.displayDropdown = function(){
    this.change(function() {
        $.post("iterations", $("#show_iteration_form").serialize(), null, "script");
        return false;       
    })
}

$(document).ready(function() {
    $("#project").displayDropdown();
})