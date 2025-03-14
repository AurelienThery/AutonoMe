// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
import HelpCallsController from "controllers/help_calls_controller"
application.register("help-calls", HelpCallsController)
eagerLoadControllersFrom("controllers", application)
