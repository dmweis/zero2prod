fn main() {
    println!("Hello, world! {}", do_thing());
}

fn do_thing() -> bool {
    true
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_method() {
        assert!(do_thing());
    }
}
