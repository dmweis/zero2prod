use log::*;
use simplelog::*;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    CombinedLogger::init(vec![TermLogger::new(
        LevelFilter::Info,
        Config::default(),
        TerminalMode::Mixed,
        ColorChoice::Auto,
    )])
    .unwrap();

    info!("Hello, world!");
    info!("Or does it?");
    info!("I guess it does!");
    Ok(())
}

#[cfg(test)]
mod test {
    // use super::*;

    #[test]
    fn passing_test() {
        assert_eq!(true, true);
    }
}
