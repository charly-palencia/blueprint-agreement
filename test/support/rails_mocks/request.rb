module RailsMocks
  class Request
    attr_reader  :fullpath, :request_method, :content_type, :authorization, :body

    def initialize(response: '', fullpath: '/message', request_method: 'GET', authorization: '', content_type: 'application/json', body: '')
      @response = response
      @fullpath = URI(fullpath)
      @request_method = request_method
      @authorization = authorization
      @body = StringIO.new(body)
      @content_type = content_type
    end

    def has_content_type?
      !content_type.nil?
    end
  end
end
