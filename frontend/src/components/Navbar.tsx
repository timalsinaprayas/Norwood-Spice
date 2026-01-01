import { Link, useLocation } from 'react-router-dom'
import './Navbar.css'

const Navbar = () => {
  const location = useLocation()

  return (
    <nav className="navbar">
      <div className="navbar-container">
        <Link to="/" className="navbar-logo">
          Norwood Spice
        </Link>
        <ul className="navbar-menu">
          <li>
            <Link
              to="/"
              className={location.pathname === '/' ? 'active' : ''}
            >
              Home
            </Link>
          </li>
          <li>
            <Link
              to="/menu"
              className={location.pathname === '/menu' ? 'active' : ''}
            >
              Menu
            </Link>
          </li>
          <li>
            <Link
              to="/about"
              className={location.pathname === '/about' ? 'active' : ''}
            >
              About
            </Link>
          </li>
        </ul>
      </div>
    </nav>
  )
}

export default Navbar

