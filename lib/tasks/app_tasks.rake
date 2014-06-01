namespace :app_tasks do
  
  desc "Start Services"
  task start_services: :environment do
    beanstalk = ApplicationHelper::Beanstalk.instance
    begin
      beanstalk.jobs.register("application-services-start") do |job|
        data = JSON.parse(job.body)

        puts "starting service #{data['service']}..."
        begin
        o = Object.const_get(data['service'], Class.new)
        o.options = data['options']
        o.start
        rescue Exception => e
          puts e.message
        end
        puts "service #{data['service']} ended..."
      end
      beanstalk.jobs.process!
    rescue
      beanstalk.close
    end
  end
  
  desc "stop Services"
  task stop_services: :environment do
    beanstalk = ApplicationHelper::Beanstalk.instance
    begin
      beanstalk.jobs.register("application-services-start") do |job|
        data = JSON.parse(job.body)

        puts "stopping service #{data['service']}..."
        begin
        o = Object.const_get(data['service'], Class.new)
        o.stop
        rescue Exception => e
          puts e.message
        end
        puts "service #{data['service']} stopped..."
      end
      beanstalk.jobs.process!
    rescue
      beanstalk.close
    end
  end  
  
end
