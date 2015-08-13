require "fileutils"
require "securerandom"

namespace :emacs do
	desc "Install the Emacs configuration"
	task :install do
		installation_target = File.join(Dir.home, ".emacs.d")

		if File.exist?(installation_target)
			FileUtils.remove_entry(installation_target)
		end

		File.symlink(File.join(File.dirname(__FILE__), ".emacs.d"), File.join(installation_target))
	end
end
