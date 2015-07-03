ready = ->
  pub = PrivatePub
  pub.subscribe "/comments", (data, channel) ->
    comment = $.parseJSON(data['comment'])

    $('form.comment').submit ->
    commentable_id = comment.commentable_id
    comment_id = comment.id
    type = comment.commentable_type

    li = $('<li/>', {class: 'comment-body', id: 'comment-' + comment_id}).append(
      $('<span>' + comment.body + '</span> <span> <a class="delete-comment" data-comment-id= ' +
          comment_id + ' data-remote="true" rel="nofollow" data-method="delete" href="/comments/' +
          comment_id + '">Удалить комментарий</a></span>'))

    switch type
      when 'Question' then $('ul.question-comments-show').append(li)
      when 'Answer' then $("ul.answer-comments-show##{commentable_id}").append(li)
    $('textarea.text').val('')

    pub.subscribe ->
    ($('.delete-comment').click (e) ->
      link = $(this)
      e.preventDefault();
      comment_id = link.data('commentId')
      console.log(comment_id)
      $('li#comment-' + comment_id + '.comment-body').hide())

  $('.delete-comment').click (e) ->
    link = $(this)
    e.preventDefault()
    comment_id = link.data('commentId')
    $('li#comment-' + comment_id + '.comment-body').hide()

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)