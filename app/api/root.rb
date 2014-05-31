# api module.
# @author ninoy.arnaldo@gmail.com for wishplz.com
module API
  # class root.
  # @author ninoy.arnaldo@gmail.com for wishplz.com  
  class Root < Grape::API
    prefix "api"
    version 'v1', :using => :header, :vendor => 'vendor'
    format :json

    # apis
    mount API::Services
    
    # swagger
    add_swagger_documentation
  end
end