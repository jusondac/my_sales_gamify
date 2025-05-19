import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["orderDetails", "orderDetail", "template"]

  connect() {
    // If there's no template in the DOM, create one from the first product field
    if (!this.hasTemplateTarget) {
      const template = this.orderDetailTargets[0].cloneNode(true)
      template.dataset.nestedFormTarget = "template"
      template.style.display = "none"
      this.orderDetailsTarget.appendChild(template)
    }
  }

  add(e) {
    e.preventDefault()

    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    const div = document.createElement("div")
    div.classList.add("order-detail-fields", "border-gray-700", "flex", "gap-7", "mb-2")
    div.dataset.nestedFormTarget = "orderDetail"
    div.innerHTML = content

    this.orderDetailsTarget.appendChild(div)
  }

  remove(e) {
    e.preventDefault()

    const wrapper = e.target.closest("[data-nested-form-target='orderDetail']")
    if (wrapper) {
      // Check if this is an existing record (not new)
      const destroyInput = wrapper.querySelector("input[name*='_destroy']")

      if (destroyInput) {
        // Existing record - mark for destruction
        destroyInput.value = "1"
        wrapper.style.display = "none"
      } else {
        // New record - just remove
        wrapper.remove()
      }
    }
  }
}