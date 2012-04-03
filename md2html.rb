#!/usr/bin/env ruby -wKU
# Created by James Ross <jamesr@z2live.com>

require 'rubygems'
require 'trollop'
require 'bluecloth'
require 'nokogiri'

REQUIRE_IN_ARG = true
DEBUG_SRC_FILE = "mdtest.md"

def markdownToHtml(inputFile, outputFile)
	puts "#{inputFile} => #{outputFile}"
	src = File.open(inputFile, "r").read()
	File.open(outputFile, "w") { |f| f << BlueCloth.new(src).to_html() }
end

def addGoogleSitesAttributes(htmlFile)
	html = Nokogiri::HTML(File.open(htmlFile, "r").read())
	html.xpath('//pre').each { |p| p['class'] = "sites-codeblock sites-codesnippet-block" }
	File.open(htmlFile, "w") { |f| f << html.to_html() }
end

# define and parse command line arguments
args = Trollop::options do 
	banner "Utility that converts markdown to html formatted for google sites' stylesheet."
	opt :in, "Input file", :type => :string, :required => REQUIRE_IN_ARG
	opt :out, "Output file", :type => :string
end
args[:in] = DEBUG_SRC_FILE if args[:in].nil?

# determine output file name
outputFile = args[:out]
outputFile = "#{args[:in]}.html" if outputFile.nil?

# md => html
markdownToHtml(args[:in], outputFile);

# add google-sites attributes to <pre> tags
addGoogleSitesAttributes(outputFile);
