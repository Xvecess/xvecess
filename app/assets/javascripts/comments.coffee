# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $('.link-add-comment').click (e) ->
    e.preventDefault();
    $('form.comment').slideDown()

  $('.close-add-comment').click (e) ->
    e.preventDefault();
    $('form.comment').slideUp()

#  $('form.comment').bind 'ajax:success', (e, data, status, xhr) ->
#    commentable = $.parseJSON(xhr.responseText)
#    id = commentable.commentable_id
#    type = commentable.commentable_type
#    li = '<li class="comment-body" id="comment-#{id}">' + commentable.body + '</li>'
#    if  type == 'Question'
#      $('.question-comments-show').append(li)
#    else if type == 'Answer'
#      $('.answer-comments-show#' + id).append(li)
#    $('textarea.text').val('')

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)