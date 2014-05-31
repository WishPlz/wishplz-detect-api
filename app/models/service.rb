# class service. user work logs. 
# @author ninoy.arnaldo@gmail.com for wishplz.com
class Service
  class << self
    attr_accessor :command
    attr_accessor :dir
    attr_accessor :options
  end
    
  self.command = ''
  self.dir = ''
  self.options = {}
  
  def self.start
    unless self.running?
      cmd = "#{self.dir}#{self.command}"
      args = ''
      self.options.each do |k,v|
        args += " #{k}#{v}"
      end if self.options
      cmd += args unless args.blank?
      
      puts cmd
      IO.popen(cmd) do |sh|
        #puts sh.gets
      end
    end
  end
  
  def self.stop
    if self.running?
      
      self.pids.reverse.each do |pid|
        cmd = "kill -9 #{pid}"
        puts cmd
        IO.popen(cmd) do |sh|
          puts sh.gets
        end
      end
      
    end
  end
  
  def self.pids
    output = []
    #cmd = IO.popen("ps | grep #{self.dir}#{self.command}") do |sh| 
    cmd = "ps | grep #{self.command}"
    puts cmd
    IO.popen(cmd) do |sh| 
      while not (out = sh.gets).blank? do
        output.push(out)
      end
    end
    
    pids = []
    begin
      output.each do |ln|
        puts ln
        strs = ln.split(/[\s\n]+/)
        pid = strs.first.to_i unless output.blank?
        pids.push(pid) unless strs.include?('grep')
      end
    rescue Exception => e
      puts e.message
      puts output
    end
      
    pids
  end
  
  def self.running?
    !self.pids.empty?
  end
  
  def self.queue_start(options = {})
    # get beanstalk instance
    beanstalk = ApplicationHelper::Beanstalk.instance
    tube = beanstalk.tubes["application-services-start"]
    # push message
    tube.put({ :service => self.name, :options => options}.to_json)
    beanstalk.close
  end
  
  def self.queue_stop
    # get beanstalk instance
    beanstalk = ApplicationHelper::Beanstalk.instance
    tube = beanstalk.tubes["application-services-stop"]
    # push message
    tube.put({ :service => self.name }.to_json)
    beanstalk.close    
  end
  
end