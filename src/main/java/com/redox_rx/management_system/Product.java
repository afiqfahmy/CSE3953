public class Product {
    package com.inventory.demo.model; // Double check this matches your folder path!

import jakarta.persistence.*;

@Entity
@Table(name = "products")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private Double price;
    private Integer quantity;

    // VS Code Tip: Right-click -> Source Action -> Generate Getters and Setters
}
}
