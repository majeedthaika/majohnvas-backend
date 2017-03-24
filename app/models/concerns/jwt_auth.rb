class JwtAuth
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  def self.generate_jwt(payload)
    JWT.encode payload, HMAC_SECRET, 'HS256'
  end

  def self.verify_jwt(jwt,verify)
    JWT.decode jwt, HMAC_SECRET, verify, { :algorithm => 'HS256' }
  end

  def self.decode_jwt(jwt, verify=true)
    self.verify_jwt(jwt,verify).first
  end
end
