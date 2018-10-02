function add_option_to_dropdown_field(association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $('.custom_attribute_options_content').append(content.replace(regexp, new_id));
}

function remove_option_from_dropdown_field(link){
  var element = $(link).closest(".custom_attribute_options_content");
  if (element.find(".custom_dropdown_option:visible").length == 1){
    var id = element.prop("id");
    alert("You have to have atleast one option");
    return;
  }
  $(link).prev("input[type=hidden]").val(1);
  $(link).closest(".custom_dropdown_option").fadeOut();
}