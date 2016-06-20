json.variant do
  json.width @result[:width]
  json.height @result[:height]
  json.url asset_url(@result[:url])
end