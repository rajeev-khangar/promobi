$(document).on("turbolinks:load", function(){
  $(".chosen-select").on('change', function() {
      var url = $(this).data('path');
      var status = $(this).val();
      if (status == "" || status == undefined){
        return false;
      }
      
      $.ajax({
        url: url,
        method: 'POST',
        data: {status: status}
      }).done(function(res) {
        alert('Status Changed !!!')
        return true;
      }).fail(function(res) {
        alert(res.responseText)
        return false;
      });

  })
})