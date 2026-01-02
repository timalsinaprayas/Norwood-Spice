import { useEffect, useState, useRef } from 'react'
import axios from 'axios'
import './Menu.css'

interface MenuItem {
  id: number
  name: string
  description: string
  imageUrl: string
  price: number
  special: boolean
  category: string
}

const Menu = () => {
  const [menuItems, setMenuItems] = useState<MenuItem[]>([])
  const [loading, setLoading] = useState(true)
  const [selectedCategory, setSelectedCategory] = useState<string | null>(null)
  const categoryRefs = useRef<{ [key: string]: HTMLDivElement | null }>({})

  useEffect(() => {
    const fetchMenuItems = async () => {
      try {
        const response = await axios.get('/api/menu')
        setMenuItems(response.data)
        // Set first category as default
        if (response.data.length > 0) {
          setSelectedCategory(response.data[0].category)
        }
      } catch (error) {
        console.error('Error fetching menu items:', error)
        setMenuItems([])
      } finally {
        setLoading(false)
      }
    }

    fetchMenuItems()
  }, [])

  // Group items by category
  const itemsByCategory = menuItems.reduce((acc, item) => {
    if (!acc[item.category]) {
      acc[item.category] = []
    }
    acc[item.category].push(item)
    return acc
  }, {} as { [key: string]: MenuItem[] })

  // Order categories to match the restaurant's menu order
  const categoryOrder = [
    'Specials', // Add Specials as the first category
    'Soups',
    'Salads',
    'Appetizers',
    'Indo-Nepali Corner',
    'Indian-Nepali Snacks',
    'Vegetable Entrees',
    'Seafood Entrees',
    'Non-Veg Entrees',
    'Biryani',
    'Tandoori',
    'Naan/Bread',
    'Side Orders',
    'Kids Meal',
    'Desserts',
    'Beverages'
  ]

  // Add Specials category with only special items
  const specialsItems = menuItems.filter(item => item.special)
  if (specialsItems.length > 0) {
    itemsByCategory['Specials'] = specialsItems
  }

  const categories = categoryOrder.filter(cat => itemsByCategory[cat])
  const isScrollingRef = useRef(false)

  // Scroll detection to update selected category
  useEffect(() => {
    if (categories.length === 0) return

    // Use scroll event instead of intersection observer for better control
    let ticking = false

    const updateSelectedCategory = () => {
      if (isScrollingRef.current) return

      const viewportHeight = window.innerHeight
      const scrollTop = window.scrollY
      const headerOffset = 250 // Account for sticky headers and nav

      // Find which category is currently in view
      let currentCategory = null
      let minDistance = Infinity

      categories.forEach(category => {
        const element = categoryRefs.current[category]
        if (element) {
          const rect = element.getBoundingClientRect()
          const elementTop = rect.top + scrollTop - headerOffset
          const elementCenter = elementTop + rect.height / 2

          // Calculate distance from viewport center to element center
          const distance = Math.abs((scrollTop + viewportHeight / 2) - elementCenter)

          if (distance < minDistance) {
            minDistance = distance
            currentCategory = category
          }
        }
      })

      if (currentCategory && currentCategory !== selectedCategory) {
        setSelectedCategory(currentCategory)
      }

      ticking = false
    }

    const handleScroll = () => {
      if (!ticking) {
        requestAnimationFrame(updateSelectedCategory)
        ticking = true
      }
    }

    window.addEventListener('scroll', handleScroll, { passive: true })

    // Initial check
    updateSelectedCategory()

    return () => {
      window.removeEventListener('scroll', handleScroll)
    }
  }, [categories, selectedCategory])

  const scrollToCategory = (category: string) => {
    const element = categoryRefs.current[category]
    if (element) {
      isScrollingRef.current = true
      element.scrollIntoView({ behavior: 'smooth', block: 'start' })
      setSelectedCategory(category)
      
      // Reset the flag after scrolling completes
      setTimeout(() => {
        isScrollingRef.current = false
      }, 1000)
    }
  }

  const scrollToNextCategory = () => {
    const currentIndex = categories.indexOf(selectedCategory || categories[0])
    const nextIndex = (currentIndex + 1) % categories.length
    scrollToCategory(categories[nextIndex])
  }

  const scrollToPreviousCategory = () => {
    const currentIndex = categories.indexOf(selectedCategory || categories[0])
    const prevIndex = (currentIndex - 1 + categories.length) % categories.length
    scrollToCategory(categories[prevIndex])
  }

  if (loading) {
    return (
      <div className="menu-loading">
        <div className="loading-spinner"></div>
        <p>Loading menu...</p>
      </div>
    )
  }

  return (
    <div className="menu">
      <div className="menu-header">
        <h1>Our Menu</h1>
        <p>Discover our carefully crafted dishes made with the finest ingredients</p>
      </div>

      {/* Category Navigation */}
      <div className="category-navigation">
        <div className="category-tabs">
          {categories.map((category) => (
            <button
              key={category}
              className={`category-tab ${selectedCategory === category ? 'active' : ''} ${category === 'Specials' ? 'specials-tab' : ''}`}
              onClick={() => scrollToCategory(category)}
            >
              {category === 'Specials' ? '⭐ Specials' : category}
            </button>
          ))}
        </div>
        <div className="category-arrows">
          <button className="arrow-button" onClick={scrollToPreviousCategory} aria-label="Previous category">
            ↑
          </button>
          <button className="arrow-button" onClick={scrollToNextCategory} aria-label="Next category">
            ↓
          </button>
        </div>
      </div>

      {/* Menu Items by Category */}
      <div className="menu-container">
        {categories.map((category) => (
          <div
            key={category}
            ref={(el) => (categoryRefs.current[category] = el)}
            className="category-section"
          >
            <h2 className={`category-title ${category === 'Specials' ? 'specials-title' : ''}`}>
              {category === 'Specials' ? '⭐ Special Dishes' : category}
            </h2>
            <div className="category-items">
              {itemsByCategory[category].map((item) => (
                <div key={item.id} className={`menu-item ${item.special && category !== 'Specials' ? 'special' : ''}`}>
                  {item.special && category !== 'Specials' && <div className="special-badge">⭐ Special</div>}
                  <div className="menu-item-content">
                    <div className="menu-item-text">
                      <h3>{item.name}</h3>
                      <p className="menu-item-description">
                        {item.description.length > 120
                          ? `${item.description.substring(0, 120)}...`
                          : item.description
                        }
                      </p>
                      <p className="menu-item-price">${item.price.toFixed(2)}</p>
                    </div>
                    <div className="menu-item-image">
                      <img
                        src={item.imageUrl}
                        alt={item.name}
                        onError={(e) => {
                          const target = e.target as HTMLImageElement;
                          target.src = 'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=800'; // Fallback to a generic food image
                        }}
                      />
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </div>
        ))}
      </div>
    </div>
  )
}

export default Menu
