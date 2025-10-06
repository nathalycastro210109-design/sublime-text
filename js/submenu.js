document.addEventListener('DOMContentLoaded', function () {
  // Select all submenu parent elements on the page
  const submenus = document.querySelectorAll('.submenu > a');

  submenus.forEach(submenu => {
    submenu.addEventListener('click', function (event) {
      // Prevent the default link behavior since it's a toggle
      event.preventDefault();

      // Find the direct parent `<li>` of the clicked `<a>`
      const parentLi = this.parentElement;

      // Find the submenu list within this specific `<li>`
      const submenuList = parentLi.querySelector('.submenu-lista');

      // Check if the currently clicked submenu is already open
      const isOpen = submenuList.style.display === 'block';

      // First, close all submenus on the page to ensure only one is open at a time
      document.querySelectorAll('.submenu-lista').forEach(list => {
        list.style.display = 'none';
      });

      // If the clicked submenu was not already open, open it.
      // If it was open, the above code has already closed it.
      if (!isOpen) {
        submenuList.style.display = 'block';
      }
    });
  });

  // Add a global click listener to close submenus when clicking outside
  window.addEventListener('click', function(event) {
    // Check if the click happened outside of a submenu container
    // `event.target.closest('.submenu')` will be null if the click is outside
    if (!event.target.closest('.submenu')) {
      document.querySelectorAll('.submenu-lista').forEach(list => {
        list.style.display = 'none';
      });
    }
  });
});