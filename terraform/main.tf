module "gpt2_model_endpoint" {
  source               = "./modules/model_endpoint"
  hf_model_id          = "gpt2"
  hf_task              = "text-generation"
  instance_count       = 1
  instance_type        = "ml.m5.xlarge"
  model_name           = "gpt2"
  repository_name      = "huggingface-pytorch-inference"
  transformers_version = "4.12.3"
}
