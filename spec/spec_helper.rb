# coding: utf-8

BINPATH = File.expand_path(File.dirname(__FILE__) + "/../bin")
libpath = File.expand_path(File.dirname(__FILE__) + "/../lib")
$LOAD_PATH << libpath unless $LOAD_PATH.include?(libpath)

require 'pebbles/nyarucode'

