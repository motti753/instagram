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
})
// main ------------------------------ //