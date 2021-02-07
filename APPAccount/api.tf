resource "aws_api_gateway_rest_api" "main" {
  name        = "app"
  description = "This is the app API "
}
resource "aws_api_gateway_resource" "ping" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "ping"
}
resource "aws_api_gateway_method" "ping" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.ping.id
  http_method   = "GET"
  authorization = "NONE"
}
resource "aws_api_gateway_resource" "pong" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "pong"
}
resource "aws_api_gateway_method" "pong" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.pong.id
  http_method   = "GET"
  authorization = "NONE"
}
