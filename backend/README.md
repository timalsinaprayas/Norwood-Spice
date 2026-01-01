# Restaurant Backend

Java Spring Boot backend API for the Bella Vista Restaurant website.

## Prerequisites

- Java 17 or higher
- Maven 3.6 or higher

## Setup

1. Build the project:
```bash
mvn clean install
```

2. Run the application:
```bash
mvn spring-boot:run
```

The API will be available at http://localhost:8080

## Database

The application uses H2 in-memory database. You can access the H2 console at:
http://localhost:8080/h2-console

JDBC URL: `jdbc:h2:mem:restaurantdb`
Username: `sa`
Password: (empty)

The database schema and initial data are automatically created on application startup.

## API Endpoints

- `GET /api/menu` - Get all menu items
- `GET /api/menu/{id}` - Get a specific menu item by ID

## Database Schema

The `menu_items` table contains:
- `id` (BIGINT PRIMARY KEY) - Auto-generated ID
- `name` (VARCHAR) - Menu item name
- `description` (VARCHAR) - Item description
- `image_url` (VARCHAR) - URL to item image
- `price` (DOUBLE) - Item price
- `special` (BOOLEAN) - Whether item is a special

The application will automatically create the schema and populate initial data on first run using the DataInitializer component.
