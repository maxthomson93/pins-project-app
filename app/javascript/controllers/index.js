// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
// import RecommendedController from "./recommended_controller"
// application.register("recommended", RecommendedController)

eagerLoadControllersFrom("controllers", application)
