class ApplicationController < ActionController::API
  SECRET = "dupa"

  def authentication
    # making a request to a secure route, token must be included in the headers
    decode_data = decode_user_data(request.headers["token"])
    # getting user id from a nested JSON in an array.
    user_data = decode_data[0]["user_id"] unless !decode_data
    # find a user in the database to be sure token is for a real user
    @current_user = User.find(user_data)

    # The barebone of this is to return true or false, as a middleware
    # its main purpose is to grant access or return an error to the user

    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
  end

  # turn user data (payload) to an encrypted string
  def encode_user_data(payload)
    JWT.encode(payload, SECRET)
  end

  # decode token and return user info, this returns an array, [payload and algorithms]
  def decode_user_data(token)
   begin
     JWT.decode(token, SECRET, true)
   rescue => e
     puts e
   end
  end

end

