# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin_all_from "app/javascript/modules", under: "modules"
pin 'axios', to: 'https://cdnjs.cloudflare.com/ajax/libs/axios/1.2.3/axios.min.js', preload: true
pin "#lib/adapters/http.js", to: "#lib--adapters--http.js.js" # @2.0.1
pin "#lib/platform/node/classes/FormData.js", to: "#lib--platform--node--classes--FormData.js.js" # @2.0.1
pin "#lib/platform/node/index.js", to: "#lib--platform--node--index.js.js" # @2.0.1
pin "jquery" # @3.7.1
