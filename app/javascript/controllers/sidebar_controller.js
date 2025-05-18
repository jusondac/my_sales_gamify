import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {
  static targets = ["supplier"]
  connect() {
    console.log("Sidebar controller connected lol");
  }

  updateSupplier() {
    console.log("Submit form triggered");
    this.element.requestSubmit();
  }
}
