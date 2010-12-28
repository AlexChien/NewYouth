xml = Builder::XmlMarkup.new(:indent =>2)
xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.data do
  items=@bulletins
  xml.result(@bulletins.count)
  items.each do |row|
     xml.id(row.id)
     xml.content("<![CDATA["+row.content+"]]>")
  end
end
