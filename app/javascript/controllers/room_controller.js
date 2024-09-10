import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="room"
export default class extends Controller {
  connect() {
    console.log("Room controller connected!")
    updateRange();
    document.getElementById('price_range').addEventListener('input', updateRange);
    function updateRange() {
      const range = document.getElementById('price_range');
      const value = ((range.value - range.min) / (range.max - range.min)) * 100;
      range.style.background = `linear-gradient(to right, #D8C2D7 ${value}%, white ${value}%)`;
      document.getElementById('price_range_value').innerText = '$' + range.value;
    }
  }
}
