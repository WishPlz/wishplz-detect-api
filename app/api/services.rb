# api module.
# @author ninoy.arnaldo@gmail.com for wishplz.com
module API
  # class users api.
  # @author ninoy.arnaldo@gmail.com for wishplz.com  
  class Services < Grape::API
    format :json
  
    resource :works do
          
          # /api/works/:id/resched
          desc "reschedules screenshot tasks"
          post ":id/resched" do
            { :status => false, :data => {}, :errors => ['Not implemented yet'] }
          end
          
    end
    
    resource :screenshots do
          
          # /api/screenshots/:id/thumbnail
          desc "generate different thumbnail versions of a screenshot"
          post ":id/thumbnail" do
            { :status => false, :data => {}, :errors => ['Not implemented yet'] }
          end
          
    end
    
  end
end