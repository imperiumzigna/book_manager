require("datatables.net")
require('datatables.net-bs4')

$(document).on("turbolinks:load", () => {
  $(function() {
    $("#products th a, #products .pagination a").on("click", function() {
      $.getScript(this.href);
      return false;
    });
    $("#products_search input").keyup(function() {
      $.get($("#products_search").attr("action"), $("#products_search").serialize(), null, "script");
      return false;
    });
  });
})