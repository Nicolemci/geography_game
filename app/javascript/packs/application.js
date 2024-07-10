// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "packs/sortable";
//= require sortable
// app/javascript/packs/application.js
// app/javascript/packs/application.js

document.addEventListener('turbolinks:load', function() {
  const swapButtons = document.querySelectorAll('.swap-button');

  swapButtons.forEach(button => {
    button.addEventListener('click', function(e) {
      e.preventDefault();
      const countryId = this.dataset.countryId;

      // Simulate swap action (e.g., by sending a request to the server)
      fetch(`/swap_countries/${countryId}`, { method: 'POST' })
        .then(response => {
          if (response.ok) {
            // Reload the page after successful swap
            Turbolinks.visit(window.location, { action: 'replace' });
          } else {
            console.error('Failed to swap countries');
          }
        })
        .catch(error => console.error('Error swapping countries:', error));
    });
  });
});
