#lazy load everything since its small
Dir[File.expand_path(File.join(File.dirname(__FILE__),'../lib','**','*.rb'))].each {|f| require f}