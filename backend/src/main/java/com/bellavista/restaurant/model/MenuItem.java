package com.norwoodspice.restaurant.model;

import jakarta.persistence.*;

@Entity
@Table(name = "menu_items")
public class MenuItem {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String name;
    
    @Column(length = 1000)
    private String description;
    
    @Column(name = "image_url")
    private String imageUrl;
    
    @Column(nullable = false)
    private Double price;
    
    @Column(nullable = false)
    private Boolean special = false;
    
    @Column(nullable = false)
    private String category;
    
    public MenuItem() {
    }
    
    public MenuItem(String name, String description, String imageUrl, Double price) {
        this.name = name;
        this.description = description;
        this.imageUrl = imageUrl;
        this.price = price;
        this.special = false;
    }
    
    public MenuItem(String name, String description, String imageUrl, Double price, Boolean special) {
        this.name = name;
        this.description = description;
        this.imageUrl = imageUrl;
        this.price = price;
        this.special = special;
    }
    
    public MenuItem(String name, String description, String imageUrl, Double price, Boolean special, String category) {
        this.name = name;
        this.description = description;
        this.imageUrl = imageUrl;
        this.price = price;
        this.special = special;
        this.category = category;
    }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getImageUrl() {
        return imageUrl;
    }
    
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    
    public Double getPrice() {
        return price;
    }
    
    public void setPrice(Double price) {
        this.price = price;
    }
    
    public Boolean getSpecial() {
        return special;
    }
    
    public void setSpecial(Boolean special) {
        this.special = special;
    }
    
    public String getCategory() {
        return category;
    }
    
    public void setCategory(String category) {
        this.category = category;
    }
}

