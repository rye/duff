require 'fileutils'

RAKEFILES = Dir.glob(File.join(File.dirname(__FILE__), '*', 'Rakefile'), File::FNM_DOTMATCH)

RAKEFILES.each do |rakefile|
	if !FileUtils.identical?(rakefile, __FILE__)
		load rakefile
	end
end
