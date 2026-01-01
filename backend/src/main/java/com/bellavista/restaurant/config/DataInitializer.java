package com.norwoodspice.restaurant.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import com.norwoodspice.restaurant.model.MenuItem;
import com.norwoodspice.restaurant.repository.MenuItemRepository;

@Component
public class DataInitializer implements CommandLineRunner {
    
    @Autowired
    private MenuItemRepository menuItemRepository;
    
    @Override
    public void run(String... args) throws Exception {
        if (menuItemRepository.count() == 0) {
            // Soups
            menuItemRepository.save(new MenuItem(
                "Mulligatawny Soup",
                "Yellow lentils cooked with traditional spices and herbs. (Vegan & GF).",
                "https://images.unsplash.com/photo-1476718406336-bb5a9690ee2a?w=800",
                3.49,
                false,
                "Soups"
            ));

            menuItemRepository.save(new MenuItem(
                "Chicken Soup",
                "Chicken clear soup flavored with roasted garlic and herbs. (GF).",
                "https://images.unsplash.com/photo-1547592180-85f173990554?w=800",
                3.99,
                false, "Soups"
            ));
            
            // Salads
            menuItemRepository.save(new MenuItem(
                "Caesar Salad",
                "Romaine lettuce, Croutons, and parmesan cheese. Add Chicken: +$2.00, Add Shrimp: +$3.00",
                "https://images.unsplash.com/photo-1540420773420-3366772f4999?w=800",
                7.49,
                false, "Salads"
            ));

            menuItemRepository.save(new MenuItem(
                "Mix Green Salad",
                "Cucumbers, onion, tomatoes, mixed greens, and mixed bell peppers with a vinaigrette dressing.",
                "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800",
                7.49,
                false, "Salads"
            ));
            
            // Appetizers
            menuItemRepository.save(new MenuItem(
                "Veg Samosa (Two Pieces)",
                "Turnover filled with potato and peas stuffing. Served with mint, tamarind and onion chutneys.",
                "https://images.unsplash.com/photo-1601050690597-df0568f70950?w=800",
                4.99,
                false, "Appetizers"
            ));

            menuItemRepository.save(new MenuItem(
                "Meat Samosa (Two Pieces)",
                "Minced lamb meat, potato, and peas stuffing. Served with mint, tamarind and onion chutneys.",
                "https://images.unsplash.com/photo-1601050690597-df0568f70950?w=800",
                5.49,
                false, "Appetizers"
            ));

            menuItemRepository.save(new MenuItem(
                "Veg Pakoras",
                "Assorted fresh vegetables deep fried in chickpea batter. (Vegan and GF). Served with mint, tamarind and onion chutneys.",
                "https://images.unsplash.com/photo-1639024471283-03518883512d?w=800",
                4.49,
                false, "Appetizers"
            ));

            menuItemRepository.save(new MenuItem(
                "Paneer Pakoras",
                "Chunks of cheese marinated in chickpea batter and deep-fried. Served with mint, tamarind and onion chutneys.",
                "https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=800",
                5.49,
                false, "Appetizers"
            ));

            menuItemRepository.save(new MenuItem(
                "Fish Pakoras (GF)",
                "Boneless piece of fish, deep-fried with Indian spice in chickpea batter. Served with mint, tamarind and onion chutneys.",
                "https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800",
                6.49,
                false, "Appetizers"
            ));

            menuItemRepository.save(new MenuItem(
                "Lasooni Gobi",
                "Fried cauliflower toasted with garlic and Himalayan herbs.",
                "https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=800",
                8.99,
                false, "Appetizers"
            ));

            menuItemRepository.save(new MenuItem(
                "Aloo Tikki",
                "Mashed potatoes and pea platter deep-fried chickpea batter.",
                "https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=800",
                4.49,
                false, "Appetizers"
            ));

            menuItemRepository.save(new MenuItem(
                "Chicken Wings (6 PCS)",
                "Available in different flavors: Plain/Buffalo/BBQ.",
                "https://images.unsplash.com/photo-1567620832903-9fc6debc209f?w=800",
                7.49,
                false, "Appetizers"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Chicken Wings (12 PCS)",
                "Available in different flavors: Plain/Buffalo/BBQ.",
                "https://images.unsplash.com/photo-1567620832903-9fc6debc209f?w=800",
                13.49,
                false, "Appetizers"
            ));

            menuItemRepository.save(new MenuItem(
                "Chicken Wings (24 PCS)",
                "Available in different flavors: Plain/Buffalo/BBQ.",
                "https://images.unsplash.com/photo-1567620832903-9fc6debc209f?w=800",
                25.49,
                false, "Appetizers"
            ));

            menuItemRepository.save(new MenuItem(
                "Tangly Gold Tenders (6 PCS)",
                "Chicken tenders fried with chickpea batter.",
                "https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?w=800",
                8.49,
                false, "Appetizers"
            ));

            menuItemRepository.save(new MenuItem(
                "Tangly Gold Tenders (12 PCS)",
                "Chicken tenders fried with chickpea batter.",
                "https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?w=800",
                15.49,
                false, "Appetizers"
            ));

            menuItemRepository.save(new MenuItem(
                "Mozzarella Sticks (8 Pieces)",
                "Crispy mozzarella sticks served hot.",
                "https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800",
                6.49,
                false, "Appetizers"
            ));

            menuItemRepository.save(new MenuItem(
                "Jalapeno Poppers (8 Pieces)",
                "Spicy jalapeno peppers stuffed and fried.",
                "https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800",
                6.49,
                false, "Appetizers"
            ));

            menuItemRepository.save(new MenuItem(
                "House Special Platter",
                "Meat Samosa, veg Samosa, veg pakoras, chicken tenders, aloo tikki, paneer pakora, mozzarella stick, and jalapeno peppers.",
                "https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800",
                11.49,
                true, "Appetizers"
            ));
            
            // Indo-Nepali Corner
            menuItemRepository.save(new MenuItem(
                "Chicken Momos (8 Pieces)",
                "Nepali style dumplings: Ground chicken with minced onion, garlic, and ginger.",
                "https://images.unsplash.com/photo-1625220194771-7ebdea0b70b9?w=800",
                9.49,
                false, "Indo-Nepali Corner"
            ));

            menuItemRepository.save(new MenuItem(
                "Vegetable Momos (8 Pieces)",
                "Nepali style dumplings: Minced cabbage, potatoes, homemade cheese(Paneer), and spinach with onion, garlic, and ginger.",
                "https://images.unsplash.com/photo-1625220194771-7ebdea0b70b9?w=800",
                8.49,
                false, "Indo-Nepali Corner"
            ));

            menuItemRepository.save(new MenuItem(
                "C-Momo (Veg or Chicken)",
                "Chicken or Veg dumplings sauteed with chili paste, peppers, and onions, finished with Himalayan spices.",
                "https://images.unsplash.com/photo-1625220194771-7ebdea0b70b9?w=800",
                11.49,
                true, "Indo-Nepali Corner"
            ));

            menuItemRepository.save(new MenuItem(
                "Chowmein",
                "Pan-fried noodles sauteed with soy sauce. Add Eggs: +$2.00, Add chicken: +$3.00",
                "https://images.unsplash.com/photo-1551326844-4df70f78d0e9?w=800",
                9.99,
                false, "Indo-Nepali Corner"
            ));

            menuItemRepository.save(new MenuItem(
                "Fried Rice",
                "Rice with green beans, mushrooms, diced carrot, green peas, and other seasonal vegetables pan-fried and sauteed with soy sauce and traditional Himalayan spices. Add Eggs: +$2.00, Add chicken: +$3.00",
                "https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800",
                9.49,
                false, "Indo-Nepali Corner"
            ));

            menuItemRepository.save(new MenuItem(
                "Jeera Aloo (V)",
                "Spiced potato cooked with cumin and homemade spices.",
                "https://images.unsplash.com/photo-1551782450-17144efb5723?w=800",
                8.99,
                false, "Indo-Nepali Corner"
            ));
            
            // Indian-Nepali Snacks
            menuItemRepository.save(new MenuItem(
                "Aloo Papri Chaat",
                "Savory chaat: Potatoes with wheat fried wafers, chickpeas, yogurt, and tamarind sauce.",
                "https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=800",
                7.49,
                false, "Indian-Nepali Snacks"
            ));

            menuItemRepository.save(new MenuItem(
                "Samosa Chaat",
                "Savory chaat: Veg samosa pieces with chickpeas, yogurt, and tamarind sauce.",
                "https://images.unsplash.com/photo-1601050690597-df0568f70950?w=800",
                7.49,
                false, "Indian-Nepali Snacks"
            ));

            menuItemRepository.save(new MenuItem(
                "Lamb Sekuwa",
                "Barbecued lamb with ginger-garlic and onions with Himalayan spices.",
                "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800",
                11.49,
                false, "Indian-Nepali Snacks"
            ));

            menuItemRepository.save(new MenuItem(
                "Chicken Sekuwa",
                "Barbecued chicken with ginger-garlic and onions with flavorful Himalayan spices.",
                "https://images.unsplash.com/photo-1598103442097-8b74394b95c6?w=800",
                9.49,
                false, "Indian-Nepali Snacks"
            ));
            
            // Vegetable Entrees
            menuItemRepository.save(new MenuItem(
                "Dal Makhani",
                "Black lentil, cooked with fresh herb and spices sauteed with cream, butter, and garnished with fresh coriander. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800",
                12.49,
                false, "Vegetable Entrees"
            ));

            menuItemRepository.save(new MenuItem(
                "Tadka Dal",
                "Yellow lentil cooked with onion, tomato, and spices. (Vegan). Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800",
                12.99,
                false, "Vegetable Entrees"
            ));

            menuItemRepository.save(new MenuItem(
                "Aloo Gobi",
                "Fresh Cauliflower and potatoes gently cooked with traditional herbs and spices. (Vegan). Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=800",
                14.99,
                false, "Vegetable Entrees"
            ));

            menuItemRepository.save(new MenuItem(
                "Mixed Veg Curry",
                "Mixed garden vegetables cooked with traditional herbs and spices. (Vegan). Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1512058564366-18510be2db19?w=800",
                13.49,
                false, "Vegetable Entrees"
            ));

            menuItemRepository.save(new MenuItem(
                "Malai Kofta",
                "Balls of minced vegetables simmered in cardamom, saffron, garlic, cashews, and light cream sauce. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=800",
                14.49,
                false, "Vegetable Entrees"
            ));

            menuItemRepository.save(new MenuItem(
                "Vegetable Korma",
                "Assorted garden fresh vegetables cooked in a creamy sauce (Contains mixture of cashews, almonds, and raisins.). Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1512058564366-18510be2db19?w=800",
                14.49,
                false, "Vegetable Entrees"
            ));

            menuItemRepository.save(new MenuItem(
                "Rayo ko Saag",
                "Fresh mustard leaves sauteed with ginger, garlic, and cumin seeds. (Vegan). Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1576045057995-568f588f82fb?w=800",
                11.49,
                false, "Vegetable Entrees"
            ));

            menuItemRepository.save(new MenuItem(
                "Aloo Bodi Tama",
                "A popular Nepali curry made with bamboo shoots, black-eyed peas, and potatoes. (Vegan). Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1512058564366-18510be2db19?w=800",
                10.49,
                false, "Vegetable Entrees"
            ));

            menuItemRepository.save(new MenuItem(
                "Chana Masala",
                "White chickpeas cooked with onions and tomatoes with herbs and spices. (Vegan). Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=800",
                13.49,
                false, "Vegetable Entrees"
            ));

            menuItemRepository.save(new MenuItem(
                "Mutter Paneer",
                "Fresh peas and homemade cheese cooked in a rich gravy with herbs and spices. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=800",
                13.99,
                false, "Vegetable Entrees"
            ));

            menuItemRepository.save(new MenuItem(
                "Saag Paneer",
                "Fresh chopped spinach with onion, garlic, ginger, and homemade cheese, cooked with creamy sauce. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1576045057995-568f588f82fb?w=800",
                14.49,
                false, "Vegetable Entrees"
            ));

            menuItemRepository.save(new MenuItem(
                "Shahi Paneer Korma",
                "Homemade cheese sauteed with cashew nuts, almonds, and raisins mixed with ginger, garlic cooked in a creamy tomato sauce. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=800",
                15.49,
                true, "Vegetable Entrees"
            ));

            menuItemRepository.save(new MenuItem(
                "Paneer Tikka Masala",
                "Homemade cheese cooked in a tangy and creamy tomato sauce. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=800",
                13.99,
                false, "Vegetable Entrees"
            ));

            menuItemRepository.save(new MenuItem(
                "Shahi Bhindi Masala",
                "Fresh okra cooked with onions, ginger, tomatoes, and spices. (Vegan). Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800",
                14.99,
                false, "Vegetable Entrees"
            ));

            menuItemRepository.save(new MenuItem(
                "Baingan Bharta",
                "Roasted eggplant curry cooked with tomatoes, green peas, herbs, and spices. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=800",
                14.49,
                false, "Vegetable Entrees"
            ));

            menuItemRepository.save(new MenuItem(
                "Baingan Dopyaza",
                "Eggplant stir-fried with onions, and bell peppers and sauteed with flavorful spices. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=800",
                15.49,
                false, "Vegetable Entrees"
            ));
            
            // Seafood Entrees
            menuItemRepository.save(new MenuItem(
                "Fish Curry",
                "Codfish cooked in a thick curry sauce & garnished with fresh coriander. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1559847844-5315695dadae?w=800",
                16.99,
                false, "Seafood Entrees"
            ));

            menuItemRepository.save(new MenuItem(
                "Fish Vindaloo",
                "Codfish cooked with potatoes in tangy & spicy sauce. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1559847844-5315695dadae?w=800",
                16.49,
                false, "Seafood Entrees"
            ));

            menuItemRepository.save(new MenuItem(
                "Seafood Masala",
                "Fresh seafood(codfish, shrimp, and lobster meat) in a rich creamy tomato sauce garnished with fresh coriander. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1559847844-5315695dadae?w=800",
                17.99,
                true, "Seafood Entrees"
            ));

            menuItemRepository.save(new MenuItem(
                "Shrimp Masala",
                "Fresh shrimp cooked in a rich creamy tomato sauce garnished with fresh coriander. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1625943553852-781c6dd46faa?w=800",
                16.99,
                false, "Seafood Entrees"
            ));

            menuItemRepository.save(new MenuItem(
                "Shrimp Vindaloo",
                "Fresh Shrimp cooked with potatoes in a tangy & spicy sauce. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1625943553852-781c6dd46faa?w=800",
                16.99,
                false, "Seafood Entrees"
            ));

            menuItemRepository.save(new MenuItem(
                "Goan Shrimp Curry",
                "Fresh shrimp cooked in a sweet coconut cream gravy, & garnished with coconut flakes. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1625943553852-781c6dd46faa?w=800",
                16.99,
                false, "Seafood Entrees"
            ));

            menuItemRepository.save(new MenuItem(
                "Shrimp Saag",
                "Delicately spiced Shrimp cooked with creamy spinach. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1625943553852-781c6dd46faa?w=800",
                15.99,
                false, "Seafood Entrees"
            ));

            menuItemRepository.save(new MenuItem(
                "Shrimp Korma",
                "Delicately spiced Shrimp cooked with cashews, almonds, and raisins. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1625943553852-781c6dd46faa?w=800",
                16.99,
                false, "Seafood Entrees"
            ));

            menuItemRepository.save(new MenuItem(
                "Shrimp Dopiaza",
                "Shrimp cooked with sliced onions, tomatoes, green peppers, and spices. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1625943553852-781c6dd46faa?w=800",
                15.99,
                false, "Seafood Entrees"
            ));
            
            // Non-Veg Entrees
            menuItemRepository.save(new MenuItem(
                "Chicken Tikka Masala",
                "Boneless chicken pieces cooked in a tangy and creamy tomato sauce. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=800",
                15.49,
                false, "Non-Veg Entrees"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Chicken Korma",
                "Boneless chicken cooked in a creamy onion sauce. Contains, Cashews, almonds, and raisins. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800",
                16.99,
                false, "Non-Veg Entrees"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Chicken Curry",
                "Chicken cooked in onion gravy and garnished with fresh coriander. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800",
                15.49,
                false, "Non-Veg Entrees"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Chicken Vindaloo",
                "Chicken cooked with potatoes in a tangy & spicy sauce. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800",
                15.99,
                false, "Non-Veg Entrees"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Chicken Saag",
                "Delicately spiced chicken cooked with creamy spinach. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800",
                15.99,
                false, "Non-Veg Entrees"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Chicken Dopiaza",
                "Boneless chicken pieces cooked with onions and peppers and sauteed with sweet and spicy tomato sauce. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800",
                16.49,
                false, "Non-Veg Entrees"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Chicken Makhani",
                "Chicken tandoori pieces cooked in delicate cream containing ground cashews, raisins, and almonds, with tomato sauce. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1598103442097-8b74394b95c6?w=800",
                15.99,
                true, "Non-Veg Entrees"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Goat Curry with Bone",
                "Nepalese goat curry cooked with Himalayan spices. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800",
                17.49,
                false, "Non-Veg Entrees"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Lamb Tikka Masala",
                "Cubes of lamb baked in a clay oven, folded into a delicately creamy tomato sauce. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800",
                16.49,
                false, "Non-Veg Entrees"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Lamb Korma",
                "Lamb cooked with cashews, raisins, and almonds in a cream sauce. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800",
                16.99,
                false, "Non-Veg Entrees"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Lamb Curry",
                "Lamb cooked in onion gravy and garnished with fresh coriander. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800",
                15.99,
                false, "Non-Veg Entrees"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Lamb Vindaloo",
                "Lamb cooked with potatoes in a tangy sauce and traditional spices. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800",
                16.99,
                false, "Non-Veg Entrees"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Lamb Saag",
                "Delicately spiced lamb with creamy spinach. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800",
                16.49,
                false, "Non-Veg Entrees"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Lamb Roghan Josh",
                "Lean lamb pieces cooked in yogurt, with almonds, cashews, and raisins. Served with Basmati rice. Choose your spice level: Mild, Medium, OR Hot",
                "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800",
                16.99,
                false, "Non-Veg Entrees"
            ));
            
            // Biryani
            menuItemRepository.save(new MenuItem(
                "Vegetable Biryani",
                "Aromatic basmati rice cooked with freshly chopped vegetables, mushrooms, cashews, almonds, and golden raisins, served with plain yogurt. Contains nuts and raisins.",
                "https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=800",
                13.99,
                false, "Biryani"
            ));

            menuItemRepository.save(new MenuItem(
                "Chicken Biryani",
                "Basmati rice cooked with boneless pieces of chicken, freshly chopped vegetables, mushrooms, cashews, almonds, and golden raisins, served with plain yogurt. Contains nuts and raisins.",
                "https://images.unsplash.com/photo-1586511925558-a4c6376d1bde?w=800",
                16.99,
                false, "Biryani"
            ));

            menuItemRepository.save(new MenuItem(
                "Lamb Biryani",
                "Basmati rice cooked with boneless pieces of tender lamb meat, freshly chopped vegetables, mushrooms, cashews, almonds, and golden raisins, served with plain yogurt. Contains nuts and raisins.",
                "https://images.unsplash.com/photo-1586511925558-a4c6376d1bde?w=800",
                17.99,
                false, "Biryani"
            ));

            menuItemRepository.save(new MenuItem(
                "Shrimp Biryani",
                "Basmati rice cooked with marinated shrimp in herb and spices, freshly chopped vegetables, mushrooms, cashews, almonds, and golden raisins, served with plain yogurt. Contains nuts and raisins.",
                "https://images.unsplash.com/photo-1586511925558-a4c6376d1bde?w=800",
                16.99,
                false, "Biryani"
            ));

            menuItemRepository.save(new MenuItem(
                "Chef Special Biryani",
                "House - special basmati rice cooked with freshly chopped vegetables, pieces of chicken, lamb, and shrimp. Mixed with cashews, almonds, and golden raisins. Served with plain yogurt. Contains nuts and raisins.",
                "https://images.unsplash.com/photo-1586511925558-a4c6376d1bde?w=800",
                18.99,
                true, "Biryani"
            ));
            
            // Tandoori
            menuItemRepository.save(new MenuItem(
                "Chicken Tandoori",
                "Tender chicken, marinated in yogurt and spiced and baked on skewers in our clay oven. Served with basmati rice and masala sauce.",
                "https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800",
                14.99,
                false, "Tandoori"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Chicken Tikka Kebab",
                "All white meat, marinated in special sauce and baked on skewers in our clay oven. Served with basmati rice and masala sauce.",
                "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800",
                14.99,
                false, "Tandoori"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Lamb Tikka Kebab",
                "Succulent lamb pieces coated with sour cream and spices grilled in the clay oven. Served with basmati rice and masala sauce.",
                "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800",
                17.49,
                false, "Tandoori"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Paneer Tandoori",
                "Homemade cottage cheese pieces marinated with sour cream, herbs, and spices, grilled in the clay oven. Served with basmati rice and masala sauce.",
                "https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=800",
                16.49,
                false, "Tandoori"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Shrimp Tandoori",
                "Fresh shrimp marinated in sour cream and baked in skewers in our clay oven. Served with basmati rice and masala sauce.",
                "https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=800",
                16.99,
                false, "Tandoori"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Salmon Tandoori",
                "Pieces of salmon marinated in yogurt and spices and baked on skewers in the clay oven. Served with basmati rice and masala sauce.",
                "https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=800",
                16.99,
                false, "Tandoori"
            ));
            
            // Naan/Bread
            menuItemRepository.save(new MenuItem(
                "Plain Butter Naan",
                "Bread made with white flour in the tandoor oven. Contains eggs, and milk.",
                "https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800",
                3.25,
                false, "Naan/Bread"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Garlic Naan",
                "Bread baked stuffed with garlic and baked in the tandoor oven.",
                "https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800",
                3.99,
                false, "Naan/Bread"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Onion Naan",
                "Bread baked stuffed with onion and baked in the tandoor oven.",
                "https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800",
                4.49,
                false, "Naan/Bread"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Basil Garlic Naan",
                "Bread baked stuffed with garlic and fresh basil and baked in the tandoor oven.",
                "https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800",
                4.49,
                false, "Naan/Bread"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Aloo Naan",
                "Bread baked stuffed with seasoned peas and potatoes in the tandoor oven.",
                "https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800",
                4.49,
                false, "Naan/Bread"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Peshawari Naan",
                "Unleavened white sweet bread stuffed with cashews, coconut, almonds, and raisins.",
                "https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=800",
                4.99,
                true, "Naan/Bread"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Bhatora",
                "Deep-fried bread made with white flour.",
                "https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800",
                3.99,
                false, "Naan/Bread"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Tandoori Roti",
                "Thin leavened whole wheat bread. Can be served with butter or without butter.",
                "https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800",
                3.99,
                false, "Naan/Bread"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Poori",
                "Deep-fried puffy whole wheat bread.",
                "https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800",
                3.99,
                false, "Naan/Bread"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Plain Paratha",
                "Whole wheat bread, cooked on a griddle with butter.",
                "https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800",
                4.99,
                false, "Naan/Bread"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Aloo Paratha",
                "Whole wheat bread with spiced potatoes and peas cooked on a griddle with butter.",
                "https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800",
                5.29,
                false, "Naan/Bread"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Bread Basket",
                "A basket of bread containing one plain naan, one garlic naan, one tandoori roti, and one poori.",
                "https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800",
                11.49,
                false, "Naan/Bread"
            ));
            
            // Side Orders
            menuItemRepository.save(new MenuItem(
                "White Basmati Rice",
                "Steamed basmati rice.",
                "https://images.unsplash.com/photo-1536304993881-ff6e9eefa2a6?w=800",
                3.49,
                false, "Side Orders"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Mint Chutney (8oz)",
                "Served in an 8oz container. Contains Dairy.",
                "https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=800",
                2.49,
                false, "Side Orders"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Tamarind Chutney (8oz)",
                "Served in an 8oz container.",
                "https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=800",
                2.49,
                false, "Side Orders"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Onion Chutney (8oz)",
                "Served in an 8oz container.",
                "https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=800",
                2.49,
                false, "Side Orders"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Mango Chutney (8oz)",
                "Served in an 8oz container.",
                "https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=800",
                2.49,
                false, "Side Orders"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Mixed Pickle (8oz)",
                "Served in an 8oz container.",
                "https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=800",
                2.49,
                false, "Side Orders"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Plain Yogurt (8oz)",
                "Served in an 8oz container.",
                "https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=800",
                2.49,
                false, "Side Orders"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Papad",
                "Deep-fried and crispy wafer-like chips. Made of chickpea flour.",
                "https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=800",
                2.49,
                false, "Side Orders"
            ));
            
            menuItemRepository.save(new MenuItem(
                "French Fries",
                "Crispy golden french fries.",
                "https://images.unsplash.com/photo-1639024471283-03518883512d?w=800",
                4.49,
                false, "Side Orders"
            ));

            menuItemRepository.save(new MenuItem(
                "Onion Rings",
                "Crispy fried onion rings.",
                "https://images.unsplash.com/photo-1639024471283-03518883512d?w=800",
                4.49,
                false, "Side Orders"
            ));
            
            menuItemRepository.save(new MenuItem(
                "Tikka Masala Sauce (16oz)",
                "Creamy tomato sauce with herbs and spices. No Rice Included",
                "https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=800",
                7.49,
                false, "Side Orders"
            ));
            
            // Kids Meal
            menuItemRepository.save(new MenuItem(
                "Mac and Cheese",
                "Classic macaroni and cheese.",
                "https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=800",
                6.49,
                false, "Kids Meal"
            ));

            menuItemRepository.save(new MenuItem(
                "Tangy Chicken Tenders with French Fries",
                "Crispy chicken tenders served with french fries.",
                "https://images.unsplash.com/photo-1562967914-608f82629710?w=800",
                7.49,
                false, "Kids Meal"
            ));

            menuItemRepository.save(new MenuItem(
                "Kids Fish and Chips",
                "Battered fish with french fries.",
                "https://images.unsplash.com/photo-1639024471283-03518883512d?w=800",
                7.99,
                false, "Kids Meal"
            ));
            
            // Desserts
            menuItemRepository.save(new MenuItem(
                "Kheer",
                "Homemade rice pudding with nuts and raisins.",
                "https://images.unsplash.com/photo-1488477304112-4944851de03d?w=800",
                2.99,
                false, "Desserts"
            ));

            menuItemRepository.save(new MenuItem(
                "Gulab Jamun (4 Pieces)",
                "Milk-based balls dipped in a sweet syrup.",
                "https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=800",
                4.99,
                false, "Desserts"
            ));

            menuItemRepository.save(new MenuItem(
                "Rasmalai (4 Pieces)",
                "Sweetened creamy milk patty with pistachios.",
                "https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=800",
                4.99,
                false, "Desserts"
            ));
            
            // Beverages
            menuItemRepository.save(new MenuItem(
                "Masala Chai Tea",
                "Milk-based homemade tea with spices.",
                "https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800",
                1.99,
                false, "Beverages"
            ));

            menuItemRepository.save(new MenuItem(
                "Super Green Smoothie",
                "Kale, spinach, banana, strawberry, dates, and almond milk.",
                "https://images.unsplash.com/photo-1553530666-ba11a7da3888?w=800",
                7.49,
                false, "Beverages"
            ));

            menuItemRepository.save(new MenuItem(
                "Berry Blast Smoothie",
                "Strawberry, raspberry, blueberry, blackberry, and oats blended with almond milk and dates.",
                "https://images.unsplash.com/photo-1553530666-ba11a7da3888?w=800",
                7.49,
                false, "Beverages"
            ));

            menuItemRepository.save(new MenuItem(
                "Exotic Tropical Smoothie",
                "Mango, pineapple, banana, raspberry, and almond milk with dates.",
                "https://images.unsplash.com/photo-1553530666-ba11a7da3888?w=800",
                7.49,
                false, "Beverages"
            ));

            menuItemRepository.save(new MenuItem(
                "Mango Lassi",
                "Mango yogurt drink blended with saffron, and honey.",
                "https://images.unsplash.com/photo-1553530666-ba11a7da3888?w=800",
                3.99,
                false, "Beverages"
            ));

            menuItemRepository.save(new MenuItem(
                "Sweet Lassi",
                "Plain and sweet yogurt drink blended with honey.",
                "https://images.unsplash.com/photo-1553530666-ba11a7da3888?w=800",
                3.49,
                false, "Beverages"
            ));

            menuItemRepository.save(new MenuItem(
                "Salty Lassi",
                "Plain yogurt drink blended with salt, cumin seeds, and fresh mint leaves.",
                "https://images.unsplash.com/photo-1553530666-ba11a7da3888?w=800",
                3.49,
                false, "Beverages"
            ));
        }
    }
}
