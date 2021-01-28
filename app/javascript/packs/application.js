// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
Rails.start()
import Turbolinks from "turbolinks"
Turbolinks.start()
import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()
import "channels"
import "bootstrap"
import "@fortawesome/fontawesome-free"
import "./src/application.scss"
require("/app/javascript/packs/raty")
require('jquery')


global.$ = jQuery;
require("trix")
require("@rails/actiontext")