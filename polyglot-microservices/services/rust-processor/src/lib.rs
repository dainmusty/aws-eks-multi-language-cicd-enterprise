pub fn process_data(input: &str) -> String {
    format!("Processed: {}", input)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_process_data() {
        assert_eq!(process_data("test"), "Processed: test");
    }
}
