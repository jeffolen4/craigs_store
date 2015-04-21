$(document).ready( function () {

  $("#dropdown-cat1 > li").click( function (e) {
    $("#dropdownCat1")[0].innerHTML = e.target.text + "&nbsp;<span class=\"caret\"></span>";
    $('input[name*=selected_cat_one]')[0].value = e.target.attributes.value.value;
    $('input[name*=selected_cat_two]')[0].value = ""
    $('input[name*=selected_cat_three]')[0].value = ""
    document.getElementById("index-form").submit();
  })

  $("#dropdown-cat2 > li").click( function (e) {
    $("#dropdownCat2")[0].innerHTML = e.target.text + "&nbsp;<span class=\"caret\"></span>";
    $('input[name*=selected_cat_two]')[0].value = e.target.attributes.value.value;
    $('input[name*=selected_cat_three]')[0].value = ""
    document.getElementById("index-form").submit();
  })
  $("#dropdown-cat3 > li").click( function (e) {
    $("#dropdownCat3")[0].innerHTML = e.target.text + "&nbsp;<span class=\"caret\"></span>";
    $('input[name*=selected_cat_thrree]')[0].value = e.target.attributes.value.value;
    document.getElementById("index-form").submit();
  })

})
