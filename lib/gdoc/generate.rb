# coding: utf-8
require 'json'

module Gdoc
  
  class Generate
    
    def initialize(out_dir)
      @out_dir = out_dir
      @doc_md = []
      @api_list = []
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

    def get url &blk
      blk.call
      @doc_md << <<-md
      ### #{root}#{url}
      > #{@desc}

      content-type: #{@type}
      params:
      
      ```javascript
      #{JSON.pretty_generate @params}
      ```

      return:

      ```
      #{JSON.pretty_generate @ok}
      ```
      md
    end

    def post url &blk
    end

    def put url &blk
    end

    def del url &blk
    end

    def patch url &blk
    end

    def import source
      eval(source)
      create_file
    end

    def desc value
      @desc = value
    end

    def params type, json_

    end

    def ok code, json_
    end

    def json
    end

    def form
    end

    # output
    def to_md source
      eval(source)
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

    def create_file
      file = File.open "#{@out_dir}/#{@model}.md", 'w'
      file.puts @doc_md.join("\n") 
      file.close
    end

  end
  
end