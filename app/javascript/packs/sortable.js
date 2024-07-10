// app/javascript/packs/sortable.js

// Import Sortable.js library
import { Turbo } from "@hotwired/turbo-rails";
import Sortable from 'sortablejs';

// Wait for the Turbolinks load event to ensure compatibility with Rails Turbolinks
document.addEventListener('turbolinks:load', () => {
  // Find the sortable list element by its ID
  const sortableList = document.getElementById('sortable-list');
  const sortableForm = document.getElementById('sortable-form');

  // Ensure the sortable list element is found before initializing Sortable.js
  if (sortableList) {
    // Initialize Sortable.js with options
    new Sortable(sortableList, {
      animation: 150, // Animation speed in milliseconds
      onEnd: function(evt) { // Callback function when sorting ends
        const item = evt.item; // Get the dragged item
        const sortedItems = Array.from(sortableList.children).map(li => li.dataset.id); // Get sorted item IDs
        updateHiddenFields(sortedItems); // Update hidden form fields with sorted IDs
      }
    });

    // Handle form submission
    sortableForm.addEventListener('submit', function(e) {
      e.preventDefault(); // Prevent default form submission
      this.submit(); // Submit the form
    });
  }

  // Function to update hidden form fields with sorted item IDs
  function updateHiddenFields(sortedItems) {
    // Clear existing hidden fields before adding new ones
    document.querySelectorAll('input[name^="countries"]').forEach(input => input.remove());

    // Add hidden input fields for each sorted item ID
    sortedItems.forEach((id, index) => {
      const input = document.createElement('input');
      input.setAttribute('type', 'hidden');
      input.setAttribute('name', `countries[${index}]`);
      input.setAttribute('value', id);
      sortableForm.appendChild(input); // Append input field to form
    });
  }
});
