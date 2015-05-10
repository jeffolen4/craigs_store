$(document).ready( function () {

  $("#dropdown-brand > li").click( function (e) {
    $("#dropdownBrand")[0].innerHTML = e.target.text + "&nbsp;<span class=\"caret\"></span>";
    $('input[name*=selected_brand]')[0].value = e.target.attributes.value.value;
    $('input[name*=selected_model]')[0].value = ""
    document.getElementById("index-form").submit();
  })

  $("#dropdown-model > li").click( function (e) {
    $("#dropdownModel")[0].innerHTML = e.target.text + "&nbsp;<span class=\"caret\"></span>";
    $('input[name*=selected_model]')[0].value = e.target.attributes.value.value;
    document.getElementById("index-form").submit();
  })

  $(".ink-row").click( function (e) {
    window.location.href = "/inks/" + e.currentTarget.id + "?brand=" + $('input[name*=selected_brand]')[0].value + '&model=' +
    $('input[name*=selected_model]')[0].value
  })

})
