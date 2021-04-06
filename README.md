[![Gem Version](https://badge.fury.io/rb/omniauth-dingtalk.svg)](https://badge.fury.io/rb/omniauth-dingtalk)
[![Build Status](https://travis-ci.org/liukun-lk/omniauth-dingtalk.svg?branch=master)](https://travis-ci.org/liukun-lk/omniauth-dingtalk)

# Omniauth DingTalk Strategies

Strategy to authenticate with DingTalk via OAuth2 in OmniAuth.

Get your API key at: http://open-dev.dingtalk.com/  Note the appId and the appSecret.

For more details, read the DingTalk docs: https://open-doc.dingtalk.com/docs/doc.htm?spm=0.0.0.0.oVQWJc&treeId=168&articleId=104878&docType=1

## Resolving-CVE-2015-9284

Go to: https://github.com/omniauth/omniauth/wiki/Resolving-CVE-2015-9284

## Installation

Add to your `Gemfile`:

```ruby
gem 'omniauth-dingtalk'
```

Then `bundle install`.

## appId & appSecret

Go to: https://open-doc.dingtalk.com/docs/doc.htm?spm=a219a.7629140.0.0.o96KrM&treeId=168&articleId=104882&docType=1

## Usage

Here's an example for adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :dingtalk, "Your_OAuth_App_ID", "Your_OAuth_App_Secret"
end
```

You can now access the OmniAuth DingTalk OAuth2 URL: /auth/dingtalk

For more examples please check out example/config.ru

## Auth Hash

Here's an example of an authentication hash available in the callback by accessing `request.env['omniauth.auth']`:

```ruby
{
  "provider": "dingtalk",
  "uid": "uid" # this is openid in DingTalk
}
```
