require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Dingding < OmniAuth::Strategies::OAuth2
      option :name, 'dingding'

      option :client_options,
             site:          'https://oapi.dingtalk.com',
             authorize_url: '/connect/qrconnect',
             token_url:     '/sns/gettoken',
             persistent_url: '/sns/get_persistent_code',
             token_method: :get

      option :authorize_params, scope: 'snsapi_login'

      uid do
        raw_info['openid']
      end

      info do
        {
          unionid: raw_info['unionid']
        }
      end

      extra do
        { raw_info: raw_info }
      end

      def request_phase
        params = client.auth_code.authorize_params.merge(redirect_uri: callback_url).merge(authorize_params)
        params['appid'] = params.delete('client_id')
        redirect client.authorize_url(params)
      end

      def raw_info
        @raw_info ||=
          access_token.post(options.client_options[:persistent_url] + "?access_token=#{access_token.token}") do |req|
            req.headers['Content-Type'] = 'application/json'
            req.body = "{\"tmp_auth_code\":\"#{request.params['code']}\"}"
          end.parsed
      end

      protected

      def build_access_token
        params = {
          'appid' => client.id,
          'appsecret' => client.secret
        }
        client.get_token(params)
      end
    end
  end
end
