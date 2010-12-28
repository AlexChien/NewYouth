xml = Builder::XmlMarkup.new(:indent =>2)
xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.data do
  items=@feeds
  xml.result(@feeds.count)
  items.each do |item|
    xml.row do
      xml.id(item.id)
      # xml.uid("<![CDATA["+item.user+"]]>")
      # xml.content("<![CDATA["+item.content+"]]>")
      xml.uid(item.user)
      xml.content(item.content)
    end
  end
end