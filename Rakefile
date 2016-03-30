lib_directory = File.expand_path('lib', File.dirname(__FILE__))
$LOAD_PATH.unshift(lib_directory) unless $LOAD_PATH.include?(lib_directory)

require 'fileutils'
require 'duff/logger'

RAKEFILES = Dir.glob(File.expand_path(File.join('*', 'Rakefile'), File.dirname(__FILE__)), File::FNM_DOTMATCH)

RAKEFILES.each do |rakefile|

	if !FileUtils.identical?(rakefile, __FILE__)
		Duff::LOGGER.debug "Loading #{rakefile}"
		load rakefile
	end

end
