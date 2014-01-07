#!/usr/bin/env ruby
#
#  Created by Antonio Moreno on 2007-09-23.
#  Copyright (c) 2007. All rights reserved.

def check_usage
  unless ARGV.length == 1
    puts "Forma de uso: restaura.rb paginaweb"
    exit
  end
end

paginaweb = ""
fichero = ARGV[0]
pw = fichero[/\w*/]
puts pw
path = "/Users/ammz/www/typo3"
`tar zxf $path/dummy-4.1.1.tar.gz`
