variable "model_name" {
  type    = string
  default = "gpt2"
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "instance_type" {
  type    = string
  default = "ml.m5.xlarge"
}

variable "repository_name" {
  type    = string
  default = "huggingface-pytorch-inference"
}

variable "transformers_version" {
  type    = string
  default = "4.12.3"
}

variable "hf_model_id" {
  type    = string
  default = "gpt2"
}

variable "hf_task" {
  type    = string
  default = "text-generation"
}
