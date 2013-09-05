require 'settingslogic'

class Settings < Settingslogic
  source File.join(ENV['ROOT'], 'config', 'settings.yml')
end