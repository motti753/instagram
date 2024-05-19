import axios from 'modules/axios';
import jquery from 'jquery'
window.$ = jquery

// comment ------------------------------ //
const handleCommentForm = () => {
  $('.show-comment-form').addClass('hidden')
  $('.comment-text-area').removeClass('hidden')
}

const appendNewComment = (comment) => {
  var com = `${comment.content}`
  $('.comments-container').append(
    `<div class='article_comment'><p>${escape(com)}</p></div>`
  )
}
// comment ------------------------------ //

export {
  handleCommentForm,
  appendNewComment
}