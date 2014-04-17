# Gdoc 
> 一个用来生成自动化生成api 文档的工具

## install

`gem install gdoc`

## 写法

1. 创建一个文件入口，比如 index.gdoc

```ruby
root "http://ip:3000"

def form
  @typ = 'application/x-www-form-urlencoded'
end

def auth_user
  headers AUTHORIZATION: '用户的token'
end

import 'src/session'
```

2. 创建src/session.gdoc

```ruby
model 'sessions'
url '/api/v1/sessions'

post '' do
  desc '用户登录API'
  params form, {
    email: '',
    password: '',
    system: 'win'
  }
  ok 200, {
    id: '用户ID',
    nickname: '用户昵称',
    token: '密钥'
  }
end

get '.json' do
  desc '获取用户信息'
  auth true
  auth_user
  params json, {}
  ok 200, {
    nickname: 'user nickname',
    email: 'email'
  }
end

```

目前支持get put post patch del， 可以自定义添加新的内容



