import axios from 'modules/axios';
import jquery from 'jquery';
window.$ = jquery;

// document.addEventListener('turbo:load', () => {
//   const profile = document.getElementById('profile-show')
//   const profileId = profile.dataset.profileUserId
//   const currentId = profile.dataset.currentUserId
//   console.log(profile)

//   $('.profilePage_user_image').on('click', () => {
//     if(currentId == profileId){
//       // あとでタグ追加用メソッドを定義する
//       let new_form = document.createElement('form');
//       new_form.setAttribute("class", "form1")
//       new_form.setAttribute("method", "put")
//       new_form.setAttribute("model", "@profile")
//       let new_input = document.createElement('input');
//       new_input.setAttribute("type", "file")
//       new_input.setAttribute("class", "file1")
//       let new_btn = document.createElement('input');
//       new_btn.setAttribute('type', 'submit')
//       new_btn.setAttribute('class', 'button')

//       new_form.appendChild(new_input)
//       new_form.appendChild(new_btn)
//       $('.profilePage_user_content').append(new_form)
//     }
//   })

//   $('.form1').on('submit', () => {
//     const fileInput = $(".file1");
//     const file = fileInput.files[0]

//     // ファイルが選択されていなかったら終了
//     if (file.length === 0) {
//       console.log("ファイルが選択されていません");
//       return false;
//     }else{
//       const formData = new FormData()
//       formData.append('avatar', file)
//       console.log(formData);
//       axios.put(`/${profileId}/profile`, {data: formData}, {
//         headers: formData.getHeaders()
//       })
//       .then((response) => {
//           const profile = response.data
//           console.log(profile)
//       })
//       .catch(e => {
//         console.log(e.response.data.error)
//       })
//     }
//   })
// })

// export default profile