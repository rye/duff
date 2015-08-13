require "securerandom"
require "pathname"

class CompileIgnore

	attr_reader :data
	attr_accessor :rules

	def initialize(filename)
		@filename = filename
		@rules = []
		@data = nil

		read!
		parse!
	end

	def exist?
		File.exist?(@filename)
	end

	def include?(file_or_dirname)
		parent_directory = File.dirname(@filename)

		root = Pathname.new(parent_directory)
		absolute_path = Pathname.new(File.expand_path(file_or_dirname))
		relative = absolute_path.relative_path_from(root)

		@rules.each do |rule|
			return true if relative.to_s.match(rule)
		end

		false
	end

	def read!
		raise FileNotFoundError, "#{@filename} does not exist!" unless exist?

		open(@filename, "rb") do |io|
			@data = io.read
		end
	end

	def parse!
		lines = @data.split("\n")

		noncomment_lines = lines.reject do |line|
			!line.match(/^(\s*)?#(.*)/).nil?
		end

		@rules = noncomment_lines.map do |noncomment_line|
			Regexp.new(noncomment_line)
		end
	end

end

class CompilationDirectory
	attr_accessor :path
	attr_reader :compile_ignore

	def initialize(path)
		@path = path
		@compile_ignore = CompileIgnore.new(File.join(@path, ".compileignore"))
	end

	def files
		Dir.glob(File.join(@path, "**", "*.el")).select do |file|
			!@compile_ignore.include?(file)
		end
	end

	def has_compile_ignore?
		@compile_ignore.exist?
	end
end


namespace :config do
	desc "Byte-compile the entire configuration"
	task :compile do
		directory = CompilationDirectory.new(File.join(File.dirname(__FILE__), ".emacs.d"))

		targets = directory.files

		puts "Compiling #{targets.count} files..."

		daemon_name = "build-#{SecureRandom.hex}"

		puts "Starting build daemon with socketname #{daemon_name}..."
		system "emacs --daemon=#{daemon_name}"

		targets.each_with_index do |target, index|
			puts "Compiling file #{index + 1} of #{targets.count} (#{target})..."
			system "emacsclient -c -s #{daemon_name} --eval '(progn (byte-compile-file \"#{target}\") (delete-frame))'"
		end

		puts "Killing build daemon with socketname #{daemon_name}"
		system "emacsclient -c -s #{daemon_name} --eval '(kill-emacs)'"
	end

	desc "Safely byte-compile the entire configuration on a single Emacs instance."
	task :safe_compile do
		directory = CompilationDirectory.new(File.join(File.dirname(__FILE__), ".emacs.d"))

		targets = directory.files

		puts "Compiling #{targets.count} files..."

		elisp_list = "(#{targets.map { |target| target.inspect }.join(" ")})"

		emacs_command = "emacs --eval \"(dolist (fn '#{elisp_list}) (byte-compile-file fn))\""
		system emacs_command

		puts "Done!  You should be good to go, unless something deaded."
	end

	desc "Install the configuration"
	task :install => [:compile] do
		directory = CompilationDirectory.new(File.join(File.dirname(__FILE__), ".emacs.d"))

		Dir.rmdir(File.join(Dir.home, ".emacs.d"))

		File.symlink(directory.path, File.join(Dir.home, ".emacs.d"))
	end
end
