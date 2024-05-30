import axios from 'modules/axios';
import jquery from 'jquery'
window.$ = jquery

// comment ------------------------------ //
const handleCommentForm = () => {
  $('.show-comment-form').addClass('hidden')
  $('.comment-text-area').removeClass('hidden')
}

const appendNewComment = (content, avatar) => {
  // var com = `${comment.content}`
  // var avatar = `${comment.avatar}`
  $('.comments_container').append(
    `<div class='comment_group'>
      <img src=${avatar}>
      <p>${escape(content)}</p>
    </div>`
  )
}
// comment ------------------------------ //

export {
  handleCommentForm,
  appendNewComment
}