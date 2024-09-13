import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="spinner"
export default class extends Controller {
  connect() {
    document.addEventListener('turbo:click', function() {
      document.getElementById('loading-spinner').style.display = 'block';
    });

    document.addEventListener('turbo:load', function() {
      document.getElementById('loading-spinner').style.display = 'none';
    });

    $(document).on('submit', 'form', function() {
      $('#loading-spinner').show();
    });
  }
}
