# Oauth2Dingtalk

该 Gem 的主要是使用钉钉扫码登录 Gitlab。

## Usage

1. 和其他的 Oauth2 Gem 一样，在 Gemfile 里面添加：
```
gem 'oauth2_dingtalk'
```

2. 然后在`config/initializers`里添加文件`dingding.rb`:

```ruby
# config/initializers/dingding.rb
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :dingding, "Your_OAuth_App_ID", "Your_OAuth_App_Secret"
  end
```

3. 然后可以看 example 文件里面的例子，如果是在 Rails 项目里面使用的话，可以在路由那边添加：

```ruby
  get '/auth/:provider/callback', 'sessions#create'
```

或者其他的方式。

4. 最主要的是
```
  auth = request.env["omniauth.auth"]
  auth["provider"]   # dingding
  auth["uid"]        # 用户在当前开放应用内的唯一标识
```

可参考：http://railscasts.com/episodes/241-simple-omniauth?autoplay=true
