require 'spec_helper'

describe OmniAuth::Strategies::Dingding do
  let(:client){OAuth2::Client.new('appid', 'appsecret')}
  let(:app) { ->{[200, {}, ["Hello."]]}}
  let(:request) { double('Request', :params => {}, :cookies => {}, :env => {}) }

  subject do
    OmniAuth::Strategies::Dingding.new(app, 'appid', 'secret', @options || {}).tap do |strategy|
      allow(strategy).to receive(:request) {
        request
      }
    end
  end

  before do
    OmniAuth.config.test_mode = true
  end

  after do
    OmniAuth.config.test_mode = false
  end

  describe 'client options' do
    it 'should have correct name' do
      expect(subject.options.name).to eq('dingding')
    end

    it 'should have correct site' do
      expect(subject.options.client_options.site).to eq('https://oapi.dingtalk.com')
    end

    it 'should have correct authorize url' do
      expect(subject.options.client_options.authorize_url).to eq('/connect/qrconnect')
    end

    it 'should have correct token url' do
      expect(subject.options.client_options.token_url).to eq('/sns/gettoken')
    end

    it 'should have correct persistent url' do
      expect(subject.options.client_options.persistent_url).to eq('/sns/get_persistent_code')
    end

    it 'should have correct token method' do
      expect(subject.options.client_options.token_method).to eq(:get)
    end
  end

  describe 'info' do
    before do
      allow(subject).to receive(:raw_info).and_return(raw_info_hash)
    end

    it 'should returns the unionid' do
      expect(subject.info[:unionid]).to eq(raw_info_hash['unionid'])
    end
  end

  describe 'state' do
    it 'should set state params for request as a way to verify CSRF' do
      expect(subject.authorize_params['state']).not_to be_nil
      expect(subject.authorize_params['state']).to eq(subject.session['omniauth.state'])
    end
  end

  describe "#request_phase" do
    it "redirect uri includes 'appid', 'redirect_uri', 'response_type', 'scope', 'state'" do
      callback_url = "http://exammple.com/callback"

      params = subject.client.auth_code.authorize_params.merge(redirect_uri: callback_url).merge(subject.authorize_params)
      params["appid"] = params.delete("client_id")

      expect(params["appid"]).to eq('appid')
      expect(params[:redirect_uri]).to eq(callback_url)
      expect(params["response_type"]).to eq('code')
      expect(params["scope"]).to eq('snsapi_login')
      expect(params["state"]).to eq(subject.session['omniauth.state'])
    end
  end
end

private

def raw_info_hash
  {
    'unionid' => 'unionid',
    'openid' => 'openid',
    "persistent_code" => "persistent_code"
  }
end
