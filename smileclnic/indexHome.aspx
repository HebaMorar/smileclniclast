<%@ Page Title="Home - SmileCare Dental Clinic" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="indexHome.aspx.cs" Inherits="indexHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section class="hero" id="hero-section">
        <div class="container">
            <div class="hero-inner">
                <div class="hero-content">
                    <div class="hero-badge">Trusted Dental Care Since 2008</div>
                    <h1>Your <em>Perfect Smile</em> Starts Here</h1>
                    <p class="hero-text">Book your appointment easily and manage your dental care online. Experience modern dentistry with a personal touch.</p>
                    <div class="hero-actions">
                        <a href="Appointment.aspx" class="btn btn-primary">Book Appointment</a>
                        <a href="#about-section" class="btn btn-outline">Learn More</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="about" id="about-section">
        <div class="container">
            <div class="about-inner">
                <div class="about-img-wrap animate-on-scroll">
                    <div class="about-img-box">
                   <img src="img/Clinic3.jpg" alt="Clinic" style="background-repeat:no-repeat" />
                    </div>
                    <div class="about-badge-exp">
                        <strong>15+</strong>
                        <span>Years of Excellence</span>
                    </div>
                </div>
                <div class="about-content animate-on-scroll">
                    <span class="section-tag">About Us</span>
                    <h2 class="section-title">Dedicated to Your Dental Health & Confidence</h2>
                    <p class="section-sub">SmileCare Clinic provides high-quality dental services using modern technology and personalized care.</p>
                    <div class="values-list">
                        <div class="value-item">
                            <div class="value-icon">01</div>
                            <div>
                                <h4>Patient-First Philosophy</h4>
                                <p>Every treatment is tailored to each patient's individual needs and comfort.</p>
                            </div>
                        </div>
                        <div class="value-item">
                            <div class="value-icon">02</div>
                            <div>
                                <h4>Modern Technology</h4>
                                <p>We use the latest dental equipment to ensure precise procedures.</p>
                            </div>
                        </div>
                        <div class="value-item">
                            <div class="value-icon">03</div>
                            <div>
                                <h4>Trusted Excellence</h4>
                                <p>Over 5,000 patients trust us for long-term dental care.</p>
                            </div>
                        </div>
                    </div>
                    <a href="Appointment.aspx" class="btn btn-primary">Book a Consultation</a>
                </div>
            </div>
        </div>
    </section>

    <section class="services" id="services-section">
        <div class="container">
            <div class="services-head animate-on-scroll">
                <span class="section-tag">Our Services</span>
                <h2 class="section-title">Comprehensive Dental Care</h2>
                <p class="section-sub">From routine check-ups to advanced cosmetic procedures, we offer a full range of dental services.</p>
            </div>
            <div class="services-grid">
                <div class="service-card animate-on-scroll">
                    <div class="svc-icon">01</div>
                    <h3>General Dentistry</h3>
                    <p>Comprehensive check-ups and preventive care.</p>
                </div>
                <div class="service-card animate-on-scroll">
                    <div class="svc-icon">02</div>
                    <h3>Teeth Whitening</h3>
                    <p>Professional whitening treatments for brighter smiles.</p>
                </div>
                <div class="service-card animate-on-scroll">
                    <div class="svc-icon">03</div>
                    <h3>Dental Implants</h3>
                    <p>Permanent tooth replacement solutions.</p>
                </div>
            </div>
        </div>
    </section>

    <section class="why-us" id="why-section">
        <div class="container">
            <div class="why-inner">
                <div class="why-content animate-on-scroll">
                    <span class="section-tag">Why Choose Us</span>
                    <h2 class="section-title">The SmileCare Difference</h2>
                    <p class="section-sub">We combine modern technology, experienced doctors, and personalized patient care to deliver exceptional dental experiences.</p>
                    <div class="benefits-list">
                        <div class="benefit-item">Experienced & Certified Dentists</div>
                        <div class="benefit-item">Modern Dental Equipment</div>
                        <div class="benefit-item">Comfortable & Welcoming Environment</div>
                        <div class="benefit-item">Flexible Appointment Scheduling</div>
                    </div>
                </div>
                <div class="why-stats animate-on-scroll">
                    <div class="stat-card">
                        <h3>5,000+</h3>
                        <p>Happy Patients</p>
                    </div>
                    <div class="stat-card">
                        <h3>15+</h3>
                        <p>Years of Experience</p>
                    </div>
                    <div class="stat-card">
                        <h3>98%</h3>
                        <p>Satisfaction Rate</p>
                    </div>
                    <div class="stat-card">
                        <h3>24/7</h3>
                        <p>Emergency Support</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="process-section" id="process-section">
        <div class="container">
            <div class="process-head animate-on-scroll">
                <span class="section-tag">Our Process</span>
                <h2 class="section-title">How We Work</h2>
                <p class="section-sub">Simple steps to get the dental care you deserve.</p>
            </div>
            <div class="process-grid">
                <div class="process-card animate-on-scroll">
                    <div class="process-number">1</div>
                    <h3>Book Online</h3>
                    <p>Schedule your appointment easily through our website.</p>
                </div>
                <div class="process-card animate-on-scroll">
                    <div class="process-number">2</div>
                    <h3>Consultation</h3>
                    <p>Meet with our experienced dentists for a comprehensive check-up.</p>
                </div>
                <div class="process-card animate-on-scroll">
                    <div class="process-number">3</div>
                    <h3>Treatment Plan</h3>
                    <p>Get a personalized treatment plan designed for your needs.</p>
                </div>
                <div class="process-card animate-on-scroll">
                    <div class="process-number">4</div>
                    <h3>Follow-Up</h3>
                    <p>Regular follow-ups to ensure your dental health stays perfect.</p>
                </div>
            </div>
        </div>
    </section>

    <section class="gallery" id="gallery-section">
        <div class="container">
            <div class="gallery-head animate-on-scroll">
                <span class="section-tag">Gallery</span>
                <h2 class="section-title">Before & After Transformations</h2>
                <p class="section-sub">See the amazing results we achieve for our patients.</p>
            </div>
            <div class="gallery-slider">
                <button class="gallery-btn prev-btn">
                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-bar-left" viewBox="0 0 16 16">
                      <path fill-rule="evenodd" d="M12.5 15a.5.5 0 0 1-.5-.5v-13a.5.5 0 0 1 1 0v13a.5.5 0 0 1-.5.5M10 8a.5.5 0 0 1-.5.5H3.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L3.707 7.5H9.5a.5.5 0 0 1 .5.5"/>
                  </svg>
                </button>
                <div class="gallery-scroll">
                    <div class="gallery-card animate-on-scroll">
                        <div class="gallery-img before">
                            <img src="img/Before1.jpg" alt="Before" />
                            <span class="gallery-label">Before</span>
                        </div>
                        <div class="gallery-img after">
                            <img src="img/After1.jpg" alt="After" />
                            <span class="gallery-label">After</span>
                        </div>
                    </div>
                    <div class="gallery-card animate-on-scroll">
                        <div class="gallery-img before">
                            <img src="img/Before2.jpg" alt="Before" />
                            <span class="gallery-label">Before</span>
                        </div>
                        <div class="gallery-img after">
                            <img src="img/After2.jpg" alt="After" />
                            <span class="gallery-label">After</span>
                        </div>
                    </div>
                    <div class="gallery-card animate-on-scroll">
                        <div class="gallery-img before">
                            <img src="img/Before3.jpg" alt="Before" />
                            <span class="gallery-label">Before</span>
                        </div>
                        <div class="gallery-img after">
                            <img src="img/After3.jpg" alt="After" />
                            <span class="gallery-label">After</span>
                        </div>
                    </div>
                    <div class="gallery-card animate-on-scroll">
                        <div class="gallery-img before">
                            <img src="img/Before4.jpg" alt="Before" />
                            <span class="gallery-label">Before</span>
                        </div>
                        <div class="gallery-img after">
                            <img src="img/After4.jpg" alt="After" />
                            <span class="gallery-label">After</span>
                        </div>
                    </div>
                </div>
                <button class="gallery-btn next-btn">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-bar-right" viewBox="0 0 16 16">
                      <path fill-rule="evenodd" d="M6 8a.5.5 0 0 0 .5.5h5.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3a.5.5 0 0 0 0-.708l-3-3a.5.5 0 0 0-.708.708L12.293 7.5H6.5A.5.5 0 0 0 6 8m-2.5 7a.5.5 0 0 1-.5-.5v-13a.5.5 0 0 1 1 0v13a.5.5 0 0 1-.5.5"/>
                    </svg>

                </button>
            </div>
        </div>
    </section>

    <section class="team-section" id="team-section">
        <div class="container">
            <div class="team-head animate-on-scroll">
                <span class="section-tag">Our Team</span>
                <h2 class="section-title">Meet Our Expert Dentists</h2>
                <p class="section-sub">Highly qualified professionals dedicated to your smile.</p>
            </div>
            <div class="team-grid">
                <div class="team-card animate-on-scroll">
                    <div class="team-image">
                        <img src="img/Dr. LinaMahmoud.png" alt="Dr. Lina Mahmoud" />
                    </div>
                    <div class="team-content">
                        <span class="experience">12 Years Experience</span>
                        <h3>Dr. Lina Mahmoud</h3>
                        <p>Orthodontic specialist focused on smile alignment and facial aesthetics.</p>
                    </div>
                </div>
                <div class="team-card animate-on-scroll">
                    <div class="team-image">
                        <img src="img/Dr. AhmadKhaled.png" alt="Dr. Ahmad Khaled" />
                    </div>
                    <div class="team-content">
                        <span class="experience">28 Years Experience</span>
                        <h3>Dr. Ahmad Khaled</h3>
                        <p>Founder & Lead Dentist specializing in cosmetic and restorative dentistry.</p>
                    </div>
                </div>
                <div class="team-card animate-on-scroll">
                    <div class="team-image">
                            <img src="img/Dr. Omar Al-Hassan.png" alt="Dr. Omar Al-Hassan" />
                    </div>
                    <div class="team-content">
                        <span class="experience">25 Years Experience</span>
                        <h3>Dr. Omar Al-Hassan</h3>
                        <p>Cosmetic dentist and implant expert dedicated to perfect smile design.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="testimonials-section" id="testimonials-section">
        <div class="container">
            <div class="testimonials-head animate-on-scroll">
                <span class="section-tag">Testimonials</span>
                <h2 class="section-title">What Our Patients Say</h2>
                <p class="section-sub">Real experiences from patients who trusted SmileCare Clinic.</p>
            </div>
            <div class="testimonials-grid">
                <div class="testimonial-card animate-on-scroll">
                    <div class="stars">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
                          <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                        </svg><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
                          <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                        </svg><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
                          <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                        </svg>
                    </div>
                    <p>"Amazing experience! The staff were friendly and professional. My smile has never looked better."</p>
                    <h4>Sarah Ahmed</h4>
                </div>
                <div class="testimonial-card animate-on-scroll">
                    <div class="stars">
                      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
                        <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                      </svg><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
                        <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                      </svg><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
                        <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                      </svg>
                    </div>
                    <p>"The clinic is modern and very clean. Booking appointments was quick and easy."</p>
                    <h4>Omar Khaled</h4>
                </div>
                <div class="testimonial-card animate-on-scroll">
                    <div class="stars">
                      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
                        <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                      </svg><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
                        <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                      </svg><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
                        <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                      </svg>
                    </div>
                    <p>"Highly recommended! The dentists explained everything clearly and made me feel comfortable."</p>
                    <h4>Lina Mahmoud</h4>
                </div>
            </div>
        </div>
    </section>

    <section class="faq-section" id="faq-section">
        <div class="container">
            <div class="faq-head animate-on-scroll">
                <span class="section-tag">FAQ</span>
                <h2 class="section-title">Frequently Asked Questions</h2>
            </div>
            <div class="faq-container">
                <div class="faq-item animate-on-scroll">
                    <h3>Do I need an appointment?</h3>
                    <p>Yes, appointments help us provide faster and more organized care.</p>
                </div>
                <div class="faq-item animate-on-scroll">
                    <h3>What payment methods do you accept?</h3>
                    <p>We accept cash, credit cards, and electronic payments.</p>
                </div>
                <div class="faq-item animate-on-scroll">
                    <h3>Do you offer teeth whitening services?</h3>
                    <p>Yes, we provide professional teeth whitening treatments.</p>
                </div>
                <div class="faq-item animate-on-scroll">
                    <h3>Can I book online?</h3>
                    <p>Absolutely! You can easily schedule your appointment online.</p>
                </div>
            </div>
        </div>
    </section>

    <section class="contact-section" id="contact-section">
        <div class="container">
            <div class="contact-wrapper animate-on-scroll">
                <div class="contact-info">
                    <span class="section-tag">Contact Us</span>
                    <h2 class="section-title">Get In Touch</h2>
                    <p class="section-sub">We're here to answer your questions and help you smile confidently.</p>
                    <div class="contact-item">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-geo-alt-fill" viewBox="0 0 16 16">
                            <path d="M8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10m0-7a3 3 0 1 1 0-6 3 3 0 0 1 0 6" />
                        </svg>
                        Amman, Jordan
                    </div>
                    <div class="contact-item">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-telephone-fill" viewBox="0 0 16 16">
                            <path fill-rule="evenodd" d="M1.885.511a1.745 1.745 0 0 1 2.61.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.68.68 0 0 0 .178.643l2.457 2.457a.68.68 0 0 0 .644.178l2.189-.547a1.75 1.75 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.6 18.6 0 0 1-7.01-4.42 18.6 18.6 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877z" />
                        </svg>
                        +962 7 9000 0000
                    </div>
                    <div class="contact-item">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-envelope-fill" viewBox="0 0 16 16">
                            <path d="M.05 3.555A2 2 0 0 1 2 2h12a2 2 0 0 1 1.95 1.555L8 8.414zM0 4.697v7.104l5.803-3.558zM6.761 8.83l-6.57 4.027A2 2 0 0 0 2 14h12a2 2 0 0 0 1.808-1.144l-6.57-4.027L8 9.586zm3.436-.586L16 11.801V4.697z" />
                        </svg>
                        info@smilecare.com
                    </div>
                </div>
                <div class="contact-form">
                    <asp:TextBox ID="txtName" runat="server" placeholder="Your Name" required="required"></asp:TextBox>
                    <asp:TextBox ID="txtEmail" runat="server" placeholder="Your Email" TextMode="Email" required="required"></asp:TextBox>
                    <asp:TextBox ID="txtPhone" runat="server" placeholder="Phone Number" required="required"></asp:TextBox>
                    <asp:TextBox ID="txtMessage" runat="server" placeholder="Your Message" TextMode="MultiLine" Rows="5" required="required"></asp:TextBox>
                    <asp:Button ID="btnSendMessage" runat="server" Text="Send Message" CssClass="btn btn-primary" OnClick="btnSendMessage_Click" />
                </div>
            </div>
        </div>
    </section>
</asp:Content>