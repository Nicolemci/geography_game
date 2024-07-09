document.addEventListener("DOMContentLoaded", function() {
  console.log("DOM fully loaded and parsed");
  var el = document.getElementById('sortable-list');
  if (el) {
    console.log("Initializing Sortable");
    new Sortable(el, {
      animation: 150,
      onEnd: function(evt) {
        console.log("Drag ended");
        let items = document.querySelectorAll("#sortable-list li input");
        items.forEach((item, index) => {
          item.name = `countries[${index}]`;
        });
      }
    });
  } else {
    console.log("Element not found");
  }
});
