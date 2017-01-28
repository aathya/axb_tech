$(document).on('turbolinks:load', function() {
  setTimeout(function(){
  $('.flash_success_message').slideUp('slow');
  }, 3000);

  setTimeout(function(){
  $('.flash_non_success_message').slideUp('slow');
  }, 3000);

  $(document).on("click", ".add-collection-btn", function () {
     var reference = $(this).data('id');
     $(".hidden-reference").val( reference );
     // As pointed out in comments,
     // it is superfluous to have to manually call the modal.
     // $('#addBookDialog').modal('show');
  });
});