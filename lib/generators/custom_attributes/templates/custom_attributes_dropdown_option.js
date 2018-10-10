function addOptionToDropdownField(association, content) {
  var newId = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $('.custom_attribute_options_content').append(content.replace(regexp, newId));
  $('.dropdown-ca-default-select').append("<option></option>");
}

function removeOptionFromDropdownField(link){
  var element = $(link).closest(".custom_attribute_options_content");
  var option  = $(link).closest(".custom_dropdown_option");
  var optionIndex = $(".custom-attribute-dropdown-option:visible").index($(option).children(".custom-attribute-dropdown-option"));
  if (element.find(".custom_dropdown_option:visible").length == 1){
    alert("You have to have atleast one option");
    return false;
  }
  $(link).prev("input[type=hidden]").val(1);
  if(optionIndex > 0){
    $(".dropdown-ca-default-select option")[optionIndex + 1].remove();
  }
  option.fadeOut(300, function() {
    option.remove();
  });
}