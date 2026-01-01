import './Home.css'

const Home = () => {
  return (
    <div className="home">
      <section className="hero">
        <div className="hero-content">
          <h1>नमस्ते! Welcome to Norwood Spice</h1>
          <p>🏔️ Bringing You The Authentic Taste of Himalayas! 🏔️</p>
          <p>Traditional Nepali & Indian Cuisine Fresh from Our Tandoor</p>
          <div className="hero-features">
            <span>🍛 Traditional Recipes</span>
            <span>🔥 Tandoor Oven</span>
            <span>🌶️ Authentic Spices</span>
          </div>
          <a href="/menu" className="btn-primary">Discover Our Menu</a>
        </div>
      </section>

      <section className="features">
        <div className="container">
          <div className="feature-grid">
            <div className="feature-card">
              <div className="feature-icon">🏔️</div>
              <h3>Himalayan Cuisine</h3>
              <p>Authentic Nepali and Indian dishes with traditional cooking styles</p>
            </div>
            <div className="feature-card">
              <div className="feature-icon">👨‍🍳</div>
              <h3>Expert Chef</h3>
              <p>20 years of experience cooking in the finest restaurants</p>
            </div>
            <div className="feature-card">
              <div className="feature-icon">🔥</div>
              <h3>Tandoor Oven</h3>
              <p>Fresh tandoori items straight from our traditional clay oven</p>
            </div>
          </div>
        </div>
      </section>

      <section className="location">
        <div className="container">
          <h2>Find Us</h2>
          <p>We are available for Dine-in, Take-out, and Catering</p>
          <div className="map-container">
            <iframe
              src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2948.5468749999997!2d-71.2030556!3d42.1944444!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x89e6b3b2c3d4e5f6%3A0x1234567890abcdef!2s655%20Washington%20Street%2C%20Norwood%2C%20MA%2002062!5e0!3m2!1sen!2sus!4v1699999999999!5m2!1sen!2sus"
              width="100%"
              height="450"
              style={{ border: 0 }}
              allowFullScreen
              loading="lazy"
              referrerPolicy="no-referrer-when-downgrade"
              title="Restaurant Location"
            ></iframe>
          </div>
          <div className="location-info">
            <div className="info-item">
              <strong>Address:</strong>
              <p>655 Washington Street<br />Norwood, MA 02062</p>
            </div>
            <div className="info-item">
              <strong>Services:</strong>
              <p>
                Dine-in<br />
                Take-out<br />
                Catering
              </p>
            </div>
            <div className="info-item">
              <strong>Contact:</strong>
              <p>
                Phone: (781) 352-4999<br />
                Email: info@norwoodspice.com
              </p>
            </div>
          </div>
        </div>
      </section>
    </div>
  )
}

export default Home

