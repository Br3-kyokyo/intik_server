REDIS = if Rails.env.test?
          MockRedis.new
        else
          Redis.new(url: Settings.redis.url)
        end
