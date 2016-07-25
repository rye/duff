require 'logger'

module Duff

  module Logging

    class DuffFormatter < Logger::Formatter

      def call(severity, time, program_name, message)
        "#{time.strftime '%H:%M:%S (%z)'} (#{program_name ? program_name + " " : ''}#{severity}) >>> #{msg2str(message)}\n"
      end

    end

  end

  LOGGER = Logger.new(STDOUT)
  LOGGER.level = Logger::INFO
  LOGGER.formatter = Logging::DuffFormatter.new

end
