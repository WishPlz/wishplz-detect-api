# api module.
# @author ninoy.arnaldo@gmail.com for wishplz.com
module API
  # class users api.
  # @author ninoy.arnaldo@gmail.com for wishplz.com  
  class Services < Grape::API
    format :json
  
    resource :train do
          
          # /api/works/train/start
          desc "start training"
          post :start do
            ServiceTrain.queue_start
            
            { :status => true, :data => {}, :errors => [] }
          end
          
          # /api/works/train/stop
          desc "force stop training"
          post :stop do
            ServiceTrain.queue_stop
            
            { :status => true, :data => {}, :errors => [] }
          end
          
          # /api/works/train/running
          desc "query if training is running"
          post :running do
            status = false
            status = ServiceTrain.running?
            
            { :status => status, :data => {}, :errors => [] }
          end
          
    end
    
  end
end