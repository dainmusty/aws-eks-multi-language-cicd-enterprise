variable "enable_guardduty" {
  description = "Enable or disable GuardDuty"
  type        = bool
  default     = true
}

variable "finding_publishing_frequency" {
  description = "Frequency for publishing findings"
  type        = string
  default     = "FIFTEEN_MINUTES"
}

variable "tags" {
  description = "Tags for GuardDuty"
  type        = map(string)
  default     = {}
}
