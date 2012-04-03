task :gems do 
	puts "Installing gems... You may be prompted for your password."
	`sudo gem install trollop bluecloth nokogiri`
end

task :default => [:gems] do
	`chmod +x md2html.rb`
	puts "Finished."
end
