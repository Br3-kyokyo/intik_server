# algorithm
JWTSessions.algorithm = 'HS256'
JWTSessions.encryption_key = Rails.application.credentials.secret_jwt_encryption_key

# token store
JWTSessions.token_store = :redis, { redis_url: Settings.redis.url }
