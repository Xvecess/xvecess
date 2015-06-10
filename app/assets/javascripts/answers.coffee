# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.delete_answer').click (e) ->
    e.preventDefault();
    answer_id = $(this).data('answerId')
    $("#" + answer_id).hide();