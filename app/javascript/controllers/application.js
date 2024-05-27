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
  const comment1 = document.getElementById('comment-show1')
  const comment2 = document.getElementById('comment-show2')
  console.log(comment1)
  console.log(comment2)

  const commentContent = JSON.parse(comment1.dataset.commentContent)
  console.log(Array.isArray(commentContent))
  const commentAvatar = JSON.parse(comment2.dataset.avatar)
  console.log(commentContent)
  console.log(commentAvatar)
  for(let i = 0; i < commentContent.length; i++){
    appendNewComment(commentContent[i], commentAvatar[i])
  }

  // comment-btnが押されたら、comments_controller createを呼び出す
  $('.comment_btn').on('click', () => {
    const comment3 = document.getElementById
    ('comment-show3')
    const commentUser = comment3.dataset.userId
    const content = $('#comment_content').val()
    if (!content){
      window.alert('コメントを入力してください')
    }else {
      axios.post(`/api/submissions/${submissionId}/comments`, {
        comment: {content: content, user_id: commentUser}
      })
        .then((response) => {
          const comment = response.data
          // appendNewComment(comment)
          console.log(comment)
          $('#comment_content').val('')
        })
    }
  })
})
// main ------------------------------ //