function add_option_to_dropdown_field(association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $('.custom_attribute_options_content').append(content.replace(regexp, new_id));
}

function remove_option_from_dropdown_field(link){
  var element = $(link).closest(".custom_attribute_options_content");
  var option  = $(link).closest(".custom_dropdown_option");
  if (element.find(".custom_dropdown_option:visible").length == 1){
    alert("You have to have atleast one option");
    return;
  }
  $(link).prev("input[type=hidden]").val(1);
  option.fadeOut(300, function() {
    option.remove();
  });
}

function sort_ca_options_init(){
  $('.sort-custom-attribute-options').sortable({
    revert: true,
    axis: 'y',
    handle:'.multihandle',
    update: function(){
      $.post($(this).data('update-url'), $(this).sortable('serialize'));
    }
  });
}