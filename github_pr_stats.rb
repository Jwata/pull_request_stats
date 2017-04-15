#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'
Bundler.require
require 'optparse'

def main(token, repo)
  client = Octokit::Client.new(access_token:  token)
  puts client.repository(repo)
end

option = {}
OptionParser.new do |opt|
  opt.on('-t VALUE') { |v| option[:token] = v }
  opt.on('-r VALUE') { |v| option[:repo] = v }
  opt.parse!(ARGV)
end

main(option[:token], option[:repo])
