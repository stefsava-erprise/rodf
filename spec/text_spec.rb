# Copyright (c) 2010 Thiago Arrais
#
# This file is part of rODF.
#
# rODF is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as
# published by the Free Software Foundation, either version 3 of
# the License, or (at your option) any later version.

# rODF is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.

# You should have received a copy of the GNU Lesser General Public License
# along with rODF.  If not, see <http://www.gnu.org/licenses/>.

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'odf/text'

describe ODF::Text do
  it "should have the expected structure" do
    output = ODF::Text.create
    output.should have_tag('//office:document-content/*')
    output.should have_tag('//office:body/*')
    output.should have_tag('//office:text')
  end

  it "should have paragraphs" do
    output = ODF::Text.create { |doc|
      doc.paragraph "Hello"
      doc.p "World!"
    }
    output.should have_tag('//office:text/*')
    output.should have_tag('//text:p')
    ps = Hpricot(output).search('text:p')
    ps.size.should == 2
    ps.first.innerHTML.should == 'Hello'
    ps.last.innerHTML.should == 'World!'
  end
end

