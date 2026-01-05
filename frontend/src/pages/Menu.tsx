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
  const isProgrammaticScrollRef = useRef(false)

  useEffect(() => {
    const fetchMenuItems = async () => {
      try {
        const apiUrl = 'http://18.188.207.87:8080/api/menu'
        const response = await axios.get(apiUrl)
        setMenuItems(response.data)
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

  const itemsByCategory = menuItems.reduce((acc, item) => {
    if (!acc[item.category]) {
      acc[item.category] = []
    }
    acc[item.category].push(item)
    return acc
  }, {} as { [key: string]: MenuItem[] })

  const categoryOrder = [
    'Specials',
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

  const specialsItems = menuItems.filter(item => item.special)
  if (specialsItems.length > 0) {
    itemsByCategory['Specials'] = specialsItems
  }

  const categories = categoryOrder.filter(cat => itemsByCategory[cat])

  // Simple scroll detection to update selected category
  useEffect(() => {
    if (categories.length === 0) return

    const handleScroll = () => {
      if (isProgrammaticScrollRef.current) return

      const viewportHeight = window.innerHeight
      const scrollTop = window.scrollY
      const headerOffset = 250

      let currentCategory = null
      let minDistance = Infinity

      categories.forEach(category => {
        const element = categoryRefs.current[category]
        if (element) {
          const rect = element.getBoundingClientRect()
          const elementTop = rect.top + scrollTop - headerOffset
          const elementCenter = elementTop + rect.height / 2
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
    }

    window.addEventListener('scroll', handleScroll, { passive: true })

    return () => {
      window.removeEventListener('scroll', handleScroll)
    }
  }, [categories, selectedCategory])

  const scrollToCategory = (category: string) => {
    const element = categoryRefs.current[category]
    if (element) {
      setSelectedCategory(category)
      isProgrammaticScrollRef.current = true

      element.scrollIntoView({ behavior: 'smooth', block: 'start' })

      setTimeout(() => {
        isProgrammaticScrollRef.current = false
      }, 1200)
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
                          target.src = 'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=800'
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