import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="shop"
export default class extends Controller {
  connect() {
    console.log("Shop controller connected")
  }
}
