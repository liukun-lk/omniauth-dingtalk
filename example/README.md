# 运行步骤
1. 回到上一级目录运行 `gem build oauth2_dingtalk.gemspec`
2. 然后会看到一个生成文件 oauth2_dingtalk-0.2.4.gem，运行 `gem install oauth2_dingtalk-0.2.4.gem`
3. 回到 example 目录，执行 `bundle install`
4. 添加 APPID 和 APPSECRET
5. 运行 `rackup config.ru`