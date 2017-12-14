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
             sns_token: '/sns/get_sns_token',
             user_info: '/sns/getuserinfo',
             token_method: :get

      option :authorize_params, scope: 'snsapi_login'

      uid do
        raw_info['user_info']['unionid']
      end

      info do
        {
          name: raw_info['user_info']['nick'],
          ding_id: raw_info['user_info']['dingId']
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
        return persistent_code if persistent_code['errcode'] != 0
        return sns_token if sns_token['errcode'] != 0
        user_info
      end

      protected

      def build_access_token
        params = {
          'appid' => client.id,
          'appsecret' => client.secret
        }
        client.get_token(params)
      end

      def persistent_code
        @persistent_code ||=
          access_token.post(options.client_options.persistent_url + "?access_token=#{access_token.token}") do |req|
            req.headers['Content-Type'] = 'application/json'
            req.body = "{\"tmp_auth_code\":\"#{request.params['code']}\"}"
          end.parsed
      end

      def sns_token
        @sns_token ||=
          access_token.post(options.client_options.sns_token + "?access_token=#{access_token.token}") do |req|
            req.headers['Content-Type'] = 'application/json'
            req.body = "{\"openid\":\"#{@persistent_code['openid']}\",
                      \"persistent_code\":\"#{@persistent_code['persistent_code']}\"}"
          end.parsed
      end

      def user_info
        @user_info ||=
          access_token.get(options.client_options.user_info + "?sns_token=#{@sns_token['sns_token']}").parsed
      end
    end
  end
end
