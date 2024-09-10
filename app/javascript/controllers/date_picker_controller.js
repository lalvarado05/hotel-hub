import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="date-picker"
export default class extends Controller {
  connect() {
    document.addEventListener("turbo:load", function() {
      flatpickr("#date_range", {
        mode: "range",
        dateFormat: "Y-m-d",
        minDate: "today"
      });
    });
  }
}
