// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){

  $(".task-checkbox").change(function() {
    var task_id = $(this).data("task-id")
    if(this.checked) {
      $(".description-"+task_id).css('text-decoration','line-through');
      $.ajax({
        url: 'tasks/change_task_state',
        data: {id: task_id,is_completed: true},
      })
    }
    else{
      $(".description-"+task_id).css('text-decoration','none');
      $.ajax({
        url: 'tasks/change_task_state',
        data: {id: task_id,is_completed: false},
      })
    }
  });

  $( "#sortable" ).sortable();
  $( "#sortable").disableSelection();

  $(".user-searchbox").select2();



});
  
