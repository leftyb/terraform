
output "repository_name" {
  description = "The name of your GIT repository."
  value       = aws_codecommit_repository.main.repository_name
}

output "branch_name" {
  description = "The brnach of your GIT repository."
  value       = aws_codecommit_repository.main.default_branch
}