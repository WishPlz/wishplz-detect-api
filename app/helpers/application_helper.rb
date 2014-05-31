module ApplicationHelper

  # class beanstalk.
  # @author ninoy.arnaldo@gmail.com for wishplz.com  
  class Beanstalk
    # get instance of beanstalk connection
    # @return {Beaneater::Pool}
    def self.instance
      Beaneater::Pool.new(APP_CONFIG["beanstalk"]["host_port"])
    end
  end
  
  # class pusher.
  # @author ninoy.arnaldo@gmail.com for wishplz.com  
  class Pusher
    # get instance of beanstalk connection
    # @return {Beaneater::Pool}
    def self.instance
      Pusher.new
    end
  end

end
