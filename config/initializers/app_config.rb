# class appconfig.
# @author ninoy.arnaldo@gmail.com for wishplz.com
class AppConfig < Hash
  
  # initialization
  # @param hash hashed data
  # @param blk executed routine after initialization
  def initialize(hash, &blk)
    if hash.class == Hash
      # recursively convert hash to appconfig
      hash.each do |k,v|
        if v.class == Hash
          self[k] = AppConfig.new(v)
        else
          self[k] = v
        end
        self[k].freeze
      end
    else
      raise "Invalid configuration data"
    end
    
    unless blk.nil?
      yield self
    end
  end
  
  # override [] method
  # @param key hash key
  # @param blk executed routine after hash key access  
  def [](key, &blk)
    ret = super
    # eval values of type string
    if ret.class != AppConfig && ret.class == String
      ret = ret.gsub(/(\#{(.+)})/) { |match|
        match = match[2..-2]
        #print eval(match).to_s + "\n"
        # evaluate
        eval match
      }
    end
        
    unless blk.nil?
      yield self
    end
    
    ret
  end
  
  # handle accessor methods for appconfig keys
  # @param name key name
  # @param args method arguments 
  # @param blk executed routine after accessor routine
  def method_missing(name, *args, &blk)
    # getter
    if args.empty? && blk.nil? && self.key?(name.to_s)
      ret = self[name.to_s]
    # setter
    elsif args.count==1 && blk.nil? && self.key?(name.to_s[0..-2]) && name.to_s[-1].eql?("=")
      raise "can't modify frozen AppConfig"
    else
      ret = super
    end
    
    unless blk.nil?
      yield self
    end
    
    ret    
  end
  
  # handle responds_to check for appconfig keys
  def respond_to?(name, &blk)
    if blk.nil? && self.key?(name.to_s)
      ret = true
    else
      ret = super
    end
   
    unless blk.nil?
      yield self
    end
    
    ret    
  end
  
end
# parse related yaml
APP_CONFIG_PATH="#{Rails.root}/config/app_config.yml"
# assign data
APP_CONFIG=AppConfig.new( YAML.load_file(APP_CONFIG_PATH)[Rails.env] ).freeze