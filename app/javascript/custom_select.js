// app/assets/javascripts/custom_select.js

document.addEventListener("DOMContentLoaded", function() {
  const selectElement = document.querySelector(".custom-select");
  const options = selectElement.querySelectorAll("option");

  options.forEach(option => {
    const deleteIcon = document.createElement("i");
    deleteIcon.className = "fas fa-trash-alt delete-icon";
    deleteIcon.addEventListener("click", function(event) {
      event.preventDefault();
      const optionValue = option.value;
      // Remove the option from the select element
      option.remove();
      // Additional logic to perform deletion on the server-side
      // You can make an AJAX request to the server to delete the option from the database
      // Example:
      // fetch(`/delete_membership_option/${optionValue}`, { method: "DELETE" })
      //   .then(response => {
      //     if (response.ok) {
      //       // Option deleted successfully
      //     } else {
      //       // Error handling
      //     }
      //   });
    });
    option.appendChild(deleteIcon);
  });
});
