// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

//rails and storage
import Rails from "@rails/ujs"
Rails.start()
import Turbolinks from "turbolinks"
Turbolinks.start()
import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()

//css and icons
import "channels"
import "bootstrap"
import "@fortawesome/fontawesome-free"
import { library, dom } from '@fortawesome/fontawesome-svg-core'
import { fas } from '@fortawesome/free-solid-svg-icons'
import { faTwitter } from '@fortawesome/free-brands-svg-icons'
library.add(fas, faTwitter)
import "./src/application.scss"

//ratings
require("/app/javascript/packs/raty")
require('jquery')

//jquery won't work otherwise - why?
global.$ = jQuery;
require("trix")
require("@rails/actiontext")