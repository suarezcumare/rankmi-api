module Response
  def json_response(object, status = :ok, message = "")
    render json: {response: object, status: status, message: message}
  end
end