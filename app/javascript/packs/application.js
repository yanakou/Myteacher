// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.


require("@rails/ujs").start() //いいね機能に必須
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
// THIS IS MAKING jQuery AVAILABLE EVEN INSIDE Views FOLDER
global.$ = require("jquery")
require("jquery-ui")　//必須
require("tag-it")
require("tagit")
require("tweet-form")
require("header")
import "bootstrap"
import '@fortawesome/fontawesome-free/js/all';



// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
