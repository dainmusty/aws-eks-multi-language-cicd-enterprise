package com.company.service;

import org.springframework.web.bind.annotation.*;
import java.util.*;

@RestController
public class ItemController {

// ########################################################
// ROOT ENDPOINT
// ########################################################

@GetMapping("/")
public String root() {
    return "Java Service Running";
}

@GetMapping("/api/health")
public Map<String, String> health() {
    Map<String, String> response = new HashMap<>();
    response.put("status", "healthy");
    response.put("service", "java-service");
    return response;
}

@GetMapping("/api/items")
public List<Map<String, Object>> getItems() {
    return new ArrayList<>();
}

@PostMapping("/api/items")
public Map<String, Object> createItem(@RequestBody Map<String, String> item) {
    Map<String, Object> response = new HashMap<>();
    response.put("id", 1);
    response.put("name", item.get("name"));
    response.put("description", item.get("description"));
    response.put("message", "Item created");
    return response;
}

@GetMapping("/api/items/{id}")
public Map<String, Object> getItemById(@PathVariable String id) {
    Map<String, Object> response = new HashMap<>();
    response.put("id", id);
    response.put("name", "Item Name");
    response.put("description", "Item description");
    return response;
}

@PutMapping("/api/items/{id}")
public Map<String, Object> updateItem(
        @PathVariable String id,
        @RequestBody Map<String, String> item) {

    Map<String, Object> response = new HashMap<>();
    response.put("id", id);
    response.put("name", item.get("name"));
    response.put("description", item.get("description"));
    response.put("message", "Item updated");
    return response;
}

@DeleteMapping("/api/items/{id}")
public Map<String, String> deleteItem(@PathVariable String id) {
    Map<String, String> response = new HashMap<>();
    response.put("id", id);
    response.put("message", "Item deleted");
    return response;
}


}
