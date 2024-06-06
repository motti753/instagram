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

import {
  append_relationship
}from '../modules/relationship'

// like ------------------------------ //
// article/show.html.hamlで非表示にしているheartをhas_likedの戻り値によって外す
const handleHeartDisplay = (hasLiked) => {
  if(hasLiked){
    $('.active-heart').removeClass('hidden')
  }else {
    $('.inactive-heart').removeClass('hidden')
  }
  console.log(`like: ${hasLiked}`)
}
// like ------------------------------ //

// main ------------------------------ //
document.addEventListener('turbo:load', () => {
  // const submission = document.getElementById('submission-show')
  // const submissionId = submission.dataset.submissionId

  // // like ------------------------------ //
  // axios.get(`/api/submissions/${submissionId}/like`)
  //   .then((response) => {
  //     const hasLiked = response.data.hasLiked
  //     handleHeartDisplay(hasLiked)
  //   })
  // // heartをinactive, activeと切り替える
  // listenInactiveHeartEvent(submissionId)
  // listenActiveHeartEvent(submissionId)
  // // like ------------------------------ //

  // // comment-btnが押されたら、comments_controller createを呼び出す
  // $('.comment_btn').on('click', () => {
  //   const comment3 = document.getElementById
  //   ('comment-show3')
  //   const commentUser = comment3.dataset.userId
  //   const content = $('#comment_content').val()
  //   if (!content){
  //     window.alert('コメントを入力してください')
  //   }else {
  //     axios.post(`/api/submissions/${submissionId}/comments`, {
  //       comment: {content: content, user_id: commentUser}
  //     })
  //       .then((response) => {
  //         const comment = response.data
  //         console.log(comment)
  //         $('#comment_content').val('')
  //       })
  //   }
  // })

  // // comment --------------------------- //
  // // comment一覧を表示
  // const comment1 = document.getElementById('comment-show1')
  // const comment2 = document.getElementById('comment-show2')

  // const commentContent = JSON.parse(comment1.dataset.commentContent)
  // const commentAvatar = JSON.parse(comment2.dataset.avatar)
  // for(let i = 0; i < commentContent.length; i++){
  //   appendNewComment(commentContent[i], commentAvatar[i])
  // }
  // // comment --------------------------- //

  // // profile -------------------------- //
  // const profile1 = document.getElementById('profile-show1')
  // const profile2 = document.getElementById('profile-show2')

  // const profileAccount = JSON.parse(profile1.dataset.profileAccount)
  // const profileAvatar = JSON.parse(profile2.dataset.avatar)
  // for(let i = 0; i < profileAccount.length; i++){
  //   append_relationship(profileAccount[i], profileAvatar[i])
  // }
  // // profile -------------------------- //

  const currentUrl = window.location.href;
  if(currentUrl.includes('submissions')){
    const submission = document.getElementById('submission-show')
    const submissionId = submission.dataset.submissionId
  
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
            console.log(comment)
            $('#comment_content').val('')
          })
      }
    })

    // comment --------------------------- //
    // comment一覧を表示
    const comment1 = document.getElementById('comment-show1')
    const comment2 = document.getElementById('comment-show2')

    const commentContent = JSON.parse(comment1.dataset.commentContent)
    const commentAvatar = JSON.parse(comment2.dataset.avatar)
    for(let i = 0; i < commentContent.length; i++){
      appendNewComment(commentContent[i], commentAvatar[i])
    }
    // comment --------------------------- //
  }else {
    // profile -------------------------- //
    const profile1 = document.getElementById('profile-show1')
    const profile2 = document.getElementById('profile-show2')

    const profileAccount = JSON.parse(profile1.dataset.profileAccount)
    const profileAvatar = JSON.parse(profile2.dataset.avatar)
    for(let i = 0; i < profileAccount.length; i++){
      append_relationship(profileAccount[i], profileAvatar[i])
    }
    // profile -------------------------- //
  }

})
// main ------------------------------ //