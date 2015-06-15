# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('.delete_attachment').click (e) ->
    e.preventDefault();
    a_id = $(this).data('attachmentId')
    $(".row.attached-file#" + a_id).hide();

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)