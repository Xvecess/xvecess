ready = ->
  pub = PrivatePub
  pub.subscribe "/comments", (data, channel) ->
    comment = $.parseJSON(data['comment'])
    commentable_id = comment.commentable_id
    comment_id = comment.id
    type = comment.commentable_type

    li = $('<li/>', {class: 'comment-body', id: 'comment-' + comment_id}).append(
      $('<span>' + comment.body + '</span> <span> <a class="delete-comment" data-comment-id= ' +
          comment_id + ' data-remote="true" rel="nofollow" data-method="delete" href="/comments/' +
          comment_id + '">Удалить комментарий</a></span>'))

    if  type == 'Question'
      $('ul.question-comments-list').append(li)
    else if type == 'Answer'
      $('ul.answer-comments-list#' + commentable_id).append(li)
    $('textarea.text').val('')

    pub.subscribe ->
    (del_link())

  del_link()

$(document).ready(ready)
$(document).on('page:load', ready)

del_link = ->
  $('.delete-comment').click (e) ->
    link = $(this)
    e.preventDefault()
    comment_id = link.data('commentId')
    $('li#comment-' + comment_id + '.comment-body').hide()