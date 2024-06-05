import axios from 'modules/axios';
import jquery from 'jquery'
window.$ = jquery

// comment ------------------------------ //
const append_relationship = (account, avatar) => {
  $('.profile_container').append(
    `<div class='profile_group'>
      <img src=${avatar}>
      <div>
        <p class='account_name'>${escape(account)}</p>
        <p class='term'>Lost seen 3 hours ago</p>
      </div>
    </div>`
  )
}
// comment ------------------------------ //

export {
  append_relationship
}