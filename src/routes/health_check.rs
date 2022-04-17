use actix_web::{HttpResponse, Responder};

#[tracing::instrument(name = "health check hit")]
pub async fn health_check() -> impl Responder {
    tracing::info!("Health check bounce");
    HttpResponse::Ok().finish()
}
