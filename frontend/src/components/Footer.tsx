import './Footer.css'

const Footer = () => {
  const currentYear = new Date().getFullYear()

  return (
    <footer className="footer">
      <div className="container">
        <div className="footer-content">
          <div className="footer-section">
            <h3>Norwood Spice</h3>
            <p>Bringing You The Taste of Himalayas</p>
            <p>Serving Nepali and Indian Cuisine</p>
          </div>
          <div className="footer-section">
            <h4>Contact Us</h4>
            <p>📍 655 Washington Street, Norwood, MA 02062</p>
            <p>📞 (781) 352-4999</p>
            <p>📧 info@norwoodspice.com</p>
          </div>
          <div className="footer-section">
            <h4>Services</h4>
            <p>🍽️ Dine-in</p>
            <p>🥡 Take-out</p>
            <p>🎉 Catering</p>
          </div>
        </div>
        <div className="footer-bottom">
          <p>&copy; {currentYear} Norwood Spice - All Rights Reserved.</p>
        </div>
      </div>
    </footer>
  )
}

export default Footer
