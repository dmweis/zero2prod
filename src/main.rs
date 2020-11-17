fn main() {
    println!("Hello, world!");
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