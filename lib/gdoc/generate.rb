# coding: utf-8
require 'json'

module Gdoc
  
  class Generate
    
    def initialize(out_dir)
      @out_dir = out_dir
      @doc_md = []
      @api_list = []
      @docs = ''
    end

    # dsl api
    def root value
      @root = value
    end

    def model value
      @model = value
    end

    def url value
      @url = value
    end

    def get url, &blk
      gen_api_md 'get', url, &blk
    end

    def post url, &blk
      gen_api_md 'post', url, &blk
    end

    def put url, &blk
      gen_api_md 'put', url, &blk
    end

    def del url, &blk
      gen_api_md 'delete', url, &blk
    end

    def patch url, &blk
      gen_api_md 'patch', url, &blk
    end

    def import source
      eval(File.read "./#{source}.gdoc")
      create_file
    end

    def desc value
      @desc = value
    end

    def params typ, json_
      typ
      @params = json_
    end

    def ok code, json_
      @ok = json_
    end

    def headers(header_={})
      @header = header_
    end

    def auth ison=false
      @ison = ison
    end

    def json
      @typ = 'application/json'
    end

    # output
    def to_md source
      eval(File.read "./#{source}.gdoc")
      gen_api_list_md
    end

    def gen_api_list_md
      file = File.open "#{@out_dir}/index.md", 'w'
      file.puts <<-md
# index
> api 列表

api 地址: #{@root}

#{@api_list.join "\n"}
      md
      file.close
    end

    def gen_api_md method, url, &blk
      blk.call
      @doc_md << <<-md
### #{@root}#{@url}#{url}
> #{@desc}

auth: #{@ison}

headers:
```javascript
#{JSON.pretty_generate (@header || {})}
```

content-type: #{@typ}
method: #{method}
params:

```javascript
#{JSON.pretty_generate @params}
```

return:

```
#{JSON.pretty_generate @ok}
```

@docs
      md
    end

    def create_file
      file = File.open "#{@out_dir}/#{@model}.md", 'w'
      file.puts @doc_md.join("\n* * *\n\n") 
      file.close
      @doc_md = []
      @api_list << "[#{@model}](./#{@model}.md)"
    end

  end
  
end