#[allow(dead_code)]
pub fn process_data(input: &str) -> String {
    format!("Processed: {}", input)
}
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_process_data() {
        let result = process_data("sample");
        assert_eq!(result, "Processed: sample");
    }
}
