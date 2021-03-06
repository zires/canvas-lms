#
# Copyright (C) 2011 Instructure, Inc.
#
# This file is part of Canvas.
#
# Canvas is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, version 3 of the License.
#
# Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.
#

# This is our default parser.  It uses TMail to get the information out
# of the email entry. 
class TmailParser
  
  include FileSplitter
  include TMail
  
  def initialize(txt)
    @txt = txt
  end
  
  def tmail_parse
    each_entry do |entry|
      entry = entry.strip.gsub(/,\z/,'')
      output = Address.parse(entry) rescue nil
      entries << {:email => output.address, :name => output.name} if output
    end
    clean_entries
  end
  alias :parse :tmail_parse
  
  def entries
    @entries ||= []
  end
  
  def clean_entries
    entries.delete('')
    return entries.compact
  end
  
  
end
