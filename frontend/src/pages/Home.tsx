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
              src="https://maps.google.com/maps?q=655%20Washington%20Street,%20Norwood,%20MA%2002062&output=embed"
              width="100%"
              height="450"
              style={{ border: 0 }}
              allowFullScreen
              loading="lazy"
              referrerPolicy="no-referrer-when-downgrade"
              title="Norwood Spice Restaurant Location"
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

