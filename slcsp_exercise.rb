# frozen_string_literal: true

# This script is solely responsible for updating $LOAD_PATH
# and running the exercise on the command line.

$LOAD_PATH << File.expand_path("#{File.dirname(__FILE__)}/lib")

require 'processor'

Processor.process!
