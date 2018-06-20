# frozen_string_literal: true

require 'money'
require 'colorize'
require 'pry-byebug'
require_relative 'config'
Dir["bank/**/*.rb"].reverse.each {|file| require_relative file }
require_relative 'seeds'
