-- Create menu_items table if it doesn't exist
CREATE TABLE IF NOT EXISTS menu_items (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(1000),
    image_url VARCHAR(500),
    price DOUBLE PRECISION NOT NULL,
    special BOOLEAN NOT NULL DEFAULT FALSE,
    category VARCHAR(255) NOT NULL
);

-- Create index on special column for faster queries
CREATE INDEX IF NOT EXISTS idx_menu_items_special ON menu_items(special);

