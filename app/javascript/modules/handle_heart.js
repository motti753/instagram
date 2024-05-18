import axios from 'modules/axios';
import jquery from 'jquery'
window.$ = jquery

// .inactive-heartをクリックしたらlike createメソッドを呼び出し、active-heartを表示させる
const listenInactiveHeartEvent = (submissionId) => {
  $('.inactive-heart').on('click', () => {
    axios.post(`/api/submissions/${submissionId}/like`)
      .then((response) => {
        if (response.data.status == 'OK'){
          $('.inactive-heart').addClass('hidden')
          $('.active-heart').removeClass('hidden')
        }
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
  })
}

// .active-heartをクリックしたら like destroyメソッドを呼び出し、inactive-heartを表示させる
const listenActiveHeartEvent = (submissionId) => {
  $('.active-heart').on('click', () => {
    axios.delete(`/api/submissions/${submissionId}/like`)
      .then((response) => {
        if (response.data.status == 'OK'){
          $('.active-heart').addClass('hidden')
          $('.inactive-heart').removeClass('hidden')
        }
        console.log(response)
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
  })
}

// 2つのメソッドをsubmission.jsで使えるようにexportする
export {
  listenInactiveHeartEvent,  // .inactiveクリック時の処理
  listenActiveHeartEvent     // .activeクリック時の処理
}