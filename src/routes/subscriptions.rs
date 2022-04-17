use actix_web::{web, HttpResponse};

#[derive(serde::Deserialize)]
pub struct FormData {
    email: String,
    name: String,
}

pub async fn subscribe(form: web::Form<FormData>) -> HttpResponse {
    println!(
        "New subscriber named {} with email {}",
        form.name, form.email
    );
    HttpResponse::Ok().finish()
}
