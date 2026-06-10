use actix_web::{web, App, HttpResponse, HttpServer};
use serde::{Deserialize, Serialize};
use tokio::signal;

mod lib;

#[derive(Serialize, Deserialize)]
pub struct Item {
    id: u32,
    name: String,
    description: String,
}

#[derive(Serialize, Deserialize)]
pub struct HealthResponse {
    status: String,
    service: String,
    version: String,
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    // Initialize logger
    env_logger::init_from_env(env_logger::Env::new().default_filter_or("info"));

    // Read port from environment or default to 8888
    let port = std::env::var("PORT")
        .unwrap_or_else(|_| "8888".to_string())
        .parse::<u16>()
        .expect("PORT must be a valid number");

    println!("Rust Processor started successfully");
    println!("Rust Processor service running on port {}", port);

    let server = HttpServer::new(|| {
        App::new()
            .route("/", web::get().to(root))
            .route("/health", web::get().to(health_check))
            .route("/api/items", web::get().to(get_items))
            .route("/api/items", web::post().to(create_item))
            .route("/api/items/{id}", web::get().to(get_item))
            .route("/api/items/{id}", web::put().to(update_item))
            .route("/api/items/{id}", web::delete().to(delete_item))
    })
    .bind(format!("0.0.0.0:{}", port))?
    .run();

    tokio::select! {
        _ = server => {
            println!("Server exited unexpectedly");
        }
        _ = signal::ctrl_c() => {
            println!("Shutdown signal received, stopping server...");
        }
    }

    Ok(())
}

async fn root() -> HttpResponse {
    HttpResponse::Ok().body("Rust Processor Running")
}

async fn health_check() -> HttpResponse {
    let response = HealthResponse {
        status: "healthy".to_string(),
        service: "rust-processor".to_string(),
        version: "1.0.0".to_string(),
    };
    HttpResponse::Ok().json(response)
}

async fn get_items() -> HttpResponse {
    let items: Vec<Item> = vec![];
    HttpResponse::Ok().json(items)
}

async fn create_item(item: web::Json<Item>) -> HttpResponse {
    let response = serde_json::json!({
        "id": 1,
        "name": item.name,
        "description": item.description,
        "message": "Item created"
    });
    HttpResponse::Created().json(response)
}

async fn get_item(path: web::Path<u32>) -> HttpResponse {
    let id = path.into_inner();
    let item = Item {
        id,
        name: "Item Name".to_string(),
        description: "Item description".to_string(),
    };
    HttpResponse::Ok().json(item)
}

async fn update_item(path: web::Path<u32>, item: web::Json<Item>) -> HttpResponse {
    let id = path.into_inner();
    let response = serde_json::json!({
        "id": id,
        "name": item.name,
        "description": item.description,
        "message": "Item updated"
    });
    HttpResponse::Ok().json(response)
}

async fn delete_item(path: web::Path<u32>) -> HttpResponse {
    let id = path.into_inner();
    let response = serde_json::json!({
        "id": id,
        "message": "Item deleted"
    });
    HttpResponse::Ok().json(response)
}
