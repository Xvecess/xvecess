# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $('.question-vote-up').on('click').bind 'ajax:success', (e, data, status, xhr) ->
    question = $.parseJSON(xhr.responseText)
    $('.vote-question-count').html(question.vote_sum)
    $('.vote-question-reload a').show()

  $('.question-vote-down').on('click').bind 'ajax:success', (e, data, status, xhr) ->
    question = $.parseJSON(xhr.responseText)
    $('.vote-question-count').html(question.vote_sum)
    $('.vote-question-reload a').show()

  $('.question-vote-reload').on('click').bind 'ajax:success', (e, data, status, xhr) ->
    question = $.parseJSON(xhr.responseText)
    $('.vote-question-count').html(question.vote_sum)
    $('.vote-question-reload a').hide()

  PrivatePub.subscribe '/questions/all', (data, chanel) ->
    console.log(data)

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)