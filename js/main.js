document.addEventListener('DOMContentLoaded', () => {
    const loginContainer = document.querySelector('.login-container');
    const loginButtonNav = document.querySelector('nav .login-btn');
    const closeButton = document.querySelector('.close-btn');
    const loginForm = document.querySelector('.login-box form');

    // Show the login form when the navigation login button is clicked
    if (loginButtonNav) {
        loginButtonNav.addEventListener('click', (e) => {
            e.preventDefault();
            loginContainer.style.display = 'flex'; // Use flex as it's the default display style
        });
    }

    // Hide the login form when the close button is clicked
    if (closeButton) {
        closeButton.addEventListener('click', () => {
            loginContainer.style.display = 'none';
        });
    }

    // Handle form submission
    if (loginForm) {
        loginForm.addEventListener('submit', (e) => {
            e.preventDefault(); // Prevent the form from submitting the traditional way

            const emailInput = loginForm.querySelector('input[type="email"]');
            const passwordInput = loginForm.querySelector('input[type="password"]');

            if (emailInput.value.trim() === '' || passwordInput.value.trim() === '') {
                alert('Please fill in both email and password fields.');
            } else {
                // Simulate a successful login
                alert('Login successful!');
                // Here you would typically send the data to a server
                // For this example, we'll just log it to the console
                console.log('Email:', emailInput.value);
                console.log('Password:', passwordInput.value);

                // Optionally, hide the form after successful login
                loginContainer.style.display = 'none';
                loginForm.reset();
            }
        });
    }

    // Initially hide the login container
    if (loginContainer) {
        loginContainer.style.display = 'none';
    }

    // Add active class to nav links (example for 'Home')
    const navLinks = document.querySelectorAll('nav ul li a');
    navLinks.forEach(link => {
        // This is a simple example. A real implementation would check the current URL.
        if (link.textContent === 'Login') {
            link.addEventListener('click', (e) => {
                e.preventDefault();
                navLinks.forEach(l => l.classList.remove('active'));
                // No active state for the login button itself, as it opens the modal
            });
        }
    });
});