import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tables"
export default class extends Controller {
  connect() {
    console.log("Tables controller connected!");

    const tables = document.querySelectorAll("table");
    tables.forEach((table) => {
      $(table).DataTable({
        language: {
          processing: "Loading data...",

          emptyTable: "No records found.",

          info: "Showing _START_ to _END_ of _TOTAL_ entries",

          lengthMenu: "Show  _MENU_  entries",

         search: "Search in table: ",

          // Customize pagination button texts
          paginate: {
            first: "First",
            last: "Last",
            next: "Next",
            previous: "Previous"
          },

          // Customize other helpful texts
          infoEmpty: "Showing 0 to 0 of 0 entries",
          infoFiltered: "(filtered from _MAX_ total entries)",
          loadingRecords: "Loading...",
          zeroRecords: "No matching records found"
        }
      });
    });
  }
}
