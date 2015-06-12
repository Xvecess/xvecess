# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $('.delete_answer').click (e) ->
    e.preventDefault();
    answer_id = $(this).data('answerId')
    $("#" + answer_id).hide();

  $('.edit_answer-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId')
    $('form#edit-answer-' + answer_id).show();

  $('.set-best-answer').parent().addClass('set_best_answer')



$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)