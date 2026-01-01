package com.norwoodspice.restaurant.controller;

import com.bellavista.restaurant.model.MenuItem;
import com.bellavista.restaurant.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/menu")
@CrossOrigin(origins = "http://localhost:3000")
public class MenuController {
    
    @Autowired
    private MenuService menuService;
    
    @GetMapping
    public ResponseEntity<List<MenuItem>> getAllMenuItems() {
        List<MenuItem> items = menuService.getAllMenuItems();
        return ResponseEntity.ok(items);
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<MenuItem> getMenuItemById(@PathVariable Long id) {
        MenuItem item = menuService.getMenuItemById(id);
        if (item != null) {
            return ResponseEntity.ok(item);
        }
        return ResponseEntity.notFound().build();
    }
}

