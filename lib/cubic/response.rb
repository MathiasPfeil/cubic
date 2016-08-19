# Handles how to create Rack::Response
class Response < Rack::Response

  def initialize(content)
    if content[:body].respond_to?(:call)
      return super('content', &content[:body])
    end

    body = content[:body] || ''
    status = content[:status] || 200
    headers = content[:headers] || {}

    super(body, status, headers)
  end
end
