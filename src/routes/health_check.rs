use actix_web::{HttpResponse, Responder};

#[tracing::instrument(name = "Health check")]
pub async fn health_check() -> impl Responder {
    tracing::info!("Health check bounce");
    HttpResponse::Ok().finish()
}
