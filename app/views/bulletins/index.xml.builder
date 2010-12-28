xml = Builder::XmlMarkup.new(:indent =>2)
xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.data do
  items=@bulletins
  xml.result(@bulletins.count)
  items.each do |item|
    xml.row do
     xml.id(item.id)
     xml.content(item.content)
    end
  end
end
