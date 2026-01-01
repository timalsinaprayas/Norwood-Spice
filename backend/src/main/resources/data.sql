-- Insert menu items (only if table is empty)
INSERT INTO menu_items (name, description, image_url, price, special)
SELECT 'Grilled Salmon', 
       'Fresh Atlantic salmon grilled to perfection, served with seasonal vegetables and lemon butter sauce.',
       'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=800',
       24.99,
       true
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Grilled Salmon');

INSERT INTO menu_items (name, description, image_url, price, special)
SELECT 'Beef Tenderloin',
       'Premium cut of beef, slow-cooked and served with roasted potatoes and red wine reduction.',
       'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800',
       32.99,
       false
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Beef Tenderloin');

INSERT INTO menu_items (name, description, image_url, price, special)
SELECT 'Margherita Pizza',
       'Classic Italian pizza with fresh mozzarella, basil, and our signature tomato sauce.',
       'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=800',
       16.99,
       true
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Margherita Pizza');

INSERT INTO menu_items (name, description, image_url, price, special)
SELECT 'Caesar Salad',
       'Crisp romaine lettuce with homemade Caesar dressing, parmesan cheese, and croutons.',
       'https://images.unsplash.com/photo-1546793665-c74683f339c1?w=800',
       12.99,
       false
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Caesar Salad');

INSERT INTO menu_items (name, description, image_url, price, special)
SELECT 'Chocolate Lava Cake',
       'Warm chocolate cake with a molten center, served with vanilla ice cream.',
       'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=800',
       9.99,
       true
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Chocolate Lava Cake');

INSERT INTO menu_items (name, description, image_url, price, special)
SELECT 'Lobster Risotto',
       'Creamy arborio rice with fresh lobster, white wine, and parmesan cheese.',
       'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=800',
       28.99,
       false
WHERE NOT EXISTS (SELECT 1 FROM menu_items WHERE name = 'Lobster Risotto');

