// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// Inclure Rails UJS pour gérer les requêtes DELETE
import Rails from "@rails/ujs"
Rails.start()

import "@popperjs/core"
import "bootstrap"
