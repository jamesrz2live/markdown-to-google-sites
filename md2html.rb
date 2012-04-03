#!/usr/bin/env ruby -wKU
# Created by James Ross <jamesr@z2live.com>

require 'rubygems'
require 'trollop'
require 'bluecloth'
require 'nokogiri'

REQUIRE_MD_ARG = false
DEBUG_MD_FILE = "mdtest.md"

def markdownToHtml(inputFile, outputFile)
	puts "#{inputFile} => #{outputFile}"
	src = File.open(inputFile, "r").read()
	File.open(outputFile, "w") { |f| f << BlueCloth.new(src).to_html() }
end

def addGoogleSitesAttributes(htmlFile)
	html = Nokogiri::HTML(File.open(htmlFile, "r").read())
	html.xpath('//pre').each { |preTag| preTag['class'] = "sites-codeblock sites-codesnippet-block" }
	File.open(htmlFile, "w") { |f| f << html.to_html() }
end

# define and parse command line arguments
args = Trollop::options do 
	opt :md, "Input file", :type => :string, :required => REQUIRE_MD_ARG
	opt :html, "Output file", :type => :string
end
args[:md] = DEBUG_MD_FILE if args[:md].nil?

# determine output file name
outputFile = args[:html]
outputFile = "#{args[:md]}.html" if outputFile.nil?

# md => html
markdownToHtml(args[:md], outputFile);

# add google-sites attributes to <pre> tags
addGoogleSitesAttributes(outputFile);
