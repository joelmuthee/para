document.addEventListener('DOMContentLoaded', () => {
    // Mobile Menu
    const hamburger = document.querySelector('.hamburger');
    const navLinks = document.querySelector('.nav-links');

    hamburger.addEventListener('click', (e) => {
        e.stopPropagation();
        navLinks.classList.toggle('active');
        hamburger.innerHTML = navLinks.classList.contains('active') ? '<i class="fas fa-times"></i>' : '<i class="fas fa-bars"></i>';
    });

    // Close menu when clicking outside
    document.addEventListener('click', (e) => {
        if (!hamburger.contains(e.target) && !navLinks.contains(e.target)) {
            navLinks.classList.remove('active');
            hamburger.innerHTML = '<i class="fas fa-bars"></i>';
        }
    });

    // Navbar Scroll Effect
    const header = document.querySelector('header');
    window.addEventListener('scroll', () => {
        if (window.scrollY > 50) {
            header.style.background = 'rgba(18, 18, 18, 0.98)';
            header.style.padding = '10px 0';
        } else {
            header.style.background = 'rgba(18, 18, 18, 0.95)';
            header.style.padding = '15px 0';
        }
    });

    // Intersection Observer for Animation
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            } else {
                entry.target.style.opacity = '0';
                entry.target.style.transform = 'translateY(40px)';
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.service-card, .section-title, .review-card, .about-content, .about-img, .feature-card, .footer-col, .footer-grid > div, .contact-grid > div, .about-grid > div').forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(40px)';
        el.style.transition = 'opacity 0.4s ease-out, transform 0.4s ease-out';
        observer.observe(el);
    });

    // Current Year
    document.getElementById('current-year').textContent = new Date().getFullYear();

    // Branch Selection Modal Logic
    createBranchModal();
    setupBookingListeners();
});

function createBranchModal() {
    const modalHTML = `
    <div class="modal-overlay" id="branchModal">
        <div class="modal-content">
            <button class="modal-close" id="closeModal">&times;</button>
            <h3 class="modal-title">Select Branch</h3>
            
            <a href="https://wa.me/254721301748" class="branch-btn" target="_blank">
                <div class="branch-info">
                    <h4>Astrol Branch</h4>
                    <p>Astrol Petrol Station</p>
                </div>
                <i class="fas fa-chevron-right branch-arrow"></i>
            </a>

            <a href="https://wa.me/254729009225" class="branch-btn" target="_blank">
                <div class="branch-info">
                    <h4>Total Branch</h4>
                    <p>Total Energies Station</p>
                </div>
                <i class="fas fa-chevron-right branch-arrow"></i>
            </a>
        </div>
    </div>
    `;

    document.body.insertAdjacentHTML('beforeend', modalHTML);

    // Close Modal Event
    document.getElementById('closeModal').addEventListener('click', closeBranchModal);
    document.getElementById('branchModal').addEventListener('click', (e) => {
        if (e.target === document.getElementById('branchModal')) {
            closeBranchModal();
        }
    });
}

function openBranchModal(e) {
    if (e) e.preventDefault();
    document.getElementById('branchModal').classList.add('active');
}

function closeBranchModal() {
    document.getElementById('branchModal').classList.remove('active');
}

function setupBookingListeners() {
    // Select all "Book" buttons and WhatsApp widgets
    // Selector targets: 
    // .nav-links .btn (Header Book Now)
    // .hero-content .btn (Hero Book Appointment)
    // .whatsapp-float (Floating Widget)

    // We must remove existing href behavior if possible or just prevent default
    const bookingButtons = document.querySelectorAll('a[href*="wa.me"], .whatsapp-float');

    bookingButtons.forEach(btn => {
        // Check if it is a branch link inside the modal (don't intercept those!)
        if (btn.classList.contains('branch-btn')) return;

        btn.addEventListener('click', openBranchModal);
    });
}
