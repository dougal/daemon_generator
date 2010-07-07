require 'rails/generators'

class DaemonGenerator < Rails::Generators::NamedBase
  
  source_root File.expand_path('../templates', __FILE__)
  argument :daemon_name, :type => :string, :default => "application"  
  
  def generate_daemon
    # directory "lib/daemons"
    # copy_file "daemons", "script/daemons", :chmod => 0755
    template "script.rb", "lib/daemons/#{file_name}.rb"
    chmod "lib/daemons/#{file_name}.rb", 0755

    template "script_ctl", "lib/daemons/#{file_name}_ctl"
    chmod "lib/daemons/#{file_name}_ctl", 0755
    
    # BUG: destroy should check if there are any other daemons left and destroy
    copy_file "daemons.yml", "config/daemons.yml"
  end
end