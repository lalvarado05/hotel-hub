import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="date-picker"
export default class extends Controller {
  connect() {
    document.addEventListener("turbo:load", function() {
      flatpickr("#date_range", {
        mode: "range",
        altInput: true,
        altFormat: "F j, Y",
        dateFormat: "Y-m-d",
        minDate: "today",
        defaultDate: document.getElementById("date_range").value || null

      });
    });
  }
}
