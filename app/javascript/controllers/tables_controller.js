import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tables"
export default class extends Controller {
  connect() {

    console.log("Tables controller connected!");
    const tables = document.querySelectorAll("table");
    tables.forEach((table) => {
      $(table).DataTable();
    });

  }
}
