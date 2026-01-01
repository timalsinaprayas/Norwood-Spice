import './About.css'

const About = () => {
  return (
    <div className="about">
      <div className="about-container">
        <div className="about-header">
          <h1>About Norwood Spice</h1>
          <p className="about-subtitle">Bringing You The Taste of Himalayas</p>
        </div>

        <div className="about-content">
          <div className="about-section">
            <h2>Our Story</h2>
            <p>
              We have a wide variety of dishes from Nepal and India with a unique cooking style.
              We also offer tandoori items fresh out of the Tandoor (Clay oven). Come dine-in
              with us or take out, and we also provide catering for your friends and families to enjoy.
            </p>
            <p>
              We have worked to package our meals in a way that lets you bring the quality of our
              meals into your home. We always love to see you in person, but even when we can't we
              ensure that your dining experience is top notch!
            </p>
          </div>

          <div className="about-section">
            <h2>Our Chef & Staff</h2>
            <div className="chef-info">
              <div className="chef-text">
                <p>
                  With 20 years of experience cooking in the finest restaurants, our chef is excited
                  to present their vision to you and all our guests. Our caring and committed staff
                  make sure you have a fantastic experience with us.
                </p>
              </div>
            </div>
          </div>

          <div className="about-section">
            <h2>Our Services</h2>
            <div className="values-grid">
              <div className="value-card">
                <div className="value-icon">🍽️</div>
                <h3>Dine In</h3>
                <p>
                  Experience our authentic Himalayan cuisine in a warm, inviting atmosphere
                  perfect for any occasion.
                </p>
              </div>
              <div className="value-card">
                <div className="value-icon">🥡</div>
                <h3>Take Out</h3>
                <p>
                  Enjoy our carefully packaged meals that bring the quality of our cuisine
                  right to your home.
                </p>
              </div>
              <div className="value-card">
                <div className="value-icon">🎉</div>
                <h3>Catering</h3>
                <p>
                  Let us cater your special events, bringing the taste of Himalayas to your
                  friends and family gatherings.
                </p>
              </div>
            </div>
          </div>

          <div className="about-section">
            <h2>Visit Us</h2>
            <p>
              We invite you to experience the authentic flavors of Nepal and India at Norwood Spice.
              Whether you're looking for traditional tandoori items, fresh momos, or classic Indian
              curries, we're here to make your dining experience memorable.
            </p>
            <div className="visit-info">
              <div className="visit-item">
                <strong>Location:</strong>
                <p>655 Washington Street<br />Norwood, MA 02062</p>
              </div>
              <div className="visit-item">
                <strong>Contact:</strong>
                <p>Phone: (781) 352-4999</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

export default About

