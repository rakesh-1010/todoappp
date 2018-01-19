// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){

  $(".task-checkbox").change(function() {
    var task_id = $(this).data("task-id")
    var is_completed;
    if(this.checked) {
      is_completed = true
      $(".description-"+task_id).css('text-decoration','line-through');
    }
    else{
      is_completed = false
      $(".description-"+task_id).css('text-decoration','none');
    }

    $.ajax({
      method: 'PUT',
      url: 'tasks/change_task_state',
      data: {id: task_id,is_completed: is_completed},
    })

  });

  $( "#sortable" ).sortable();
  $( "#sortable").disableSelection();
});
  
