import { Application } from "@hotwired/stimulus"
import "@hotwired/turbo-rails"
import "controllers"
// import profile from "controllers/profile"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

// modules/axios.jsのデフォルト設定を読み込む
import axios from 'modules/axios';
import jquery from 'jquery'
window.$ = jquery

// modules/handle_heart.jsのメソッドを読み込み
import {
  listenInactiveHeartEvent,
  listenActiveHeartEvent
}from '../modules/handle_heart'

import {
  handleCommentForm,
  appendNewComment
}from '../modules/comments'

// like ------------------------------ //
// article/show.html.hamlで非表示にしているheartをhas_likedの戻り値によって外す
const handleHeartDisplay = (hasLiked) => {
  if(hasLiked){
    $('.active-heart').removeClass('hidden')
  }else {
    $('.inactive-heart').removeClass('hidden')
  }
  console.log(hasLiked)
}
// like ------------------------------ //

// main ------------------------------ //
document.addEventListener('turbo:load', () => {
  const submission = document.getElementById('submission-show')
  console.log(submission)

  const submissionId = submission.dataset.submissionId
  console.log(submissionId)

  // like ------------------------------ //
  axios.get(`/api/submissions/${submissionId}/like`)
    .then((response) => {
      const hasLiked = response.data.hasLiked
      handleHeartDisplay(hasLiked)
    })
  // heartをinactive, activeと切り替える
  listenInactiveHeartEvent(submissionId)
  listenActiveHeartEvent(submissionId)
  // like ------------------------------ //

  // comment一覧を表示
  axios.get(`/api/submissions/${submissionId}/comments`)
  .then((response) => {
    const comments = response.data
    comments.forEach((comment) => {
      appendNewComment(comment)
    })
  })

  // add-comment-buttonが押されたら、comments_controller createを呼び出す
  $('.add-comment-button').on('click', () => {
  const content = $('#comment_content').val()
  if (!content){
    window.alert('コメントを入力してください')
  }else {
    axios.post(`/api/submissions/${submissionId}/comments`, {
      comment: {content: content}
    })
      .then((response) => {
        const comment = response.data
        appendNewComment(comment)
        $('#comment_content').val('')
      })
  }
})
// main ------------------------------ //