(function () {
  jQuery(function() {
    jQuery.ajax("/parks/count.json",
           {
             success: function (data) {
               $('.park-count').text("現在の駐車場登録件数 " + (data.count) + "件");
             }
           }
    );
  });
}).call();
