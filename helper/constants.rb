module Constants

  # Constants
  #SOURCECODEREGEX = /<pre[^>]*>(?:<code[^>]*>)?(?:[^<])*/m
  SOURCECODEREGEX = /<pre[^>]*>.*?(?=<\/pre>)/m

  # I'll leave this one here as a memory for all the suffering i've been through
  #Regex = /<(?!pre|noscript|code|script|td|div|g)\w+>[^\n]+/

  STACKOVERFLOWREGEX = /(<p [^>]*>.*?<\/p>)|(<h\d[^>]*>.*?<\/h\d>)|(<span class="comment-copy">.*?<\/span>)/m

  WIKIURLREGEX = /(?<=href="\/)wiki\/.*?(?=")/

  GENERICREGEX = /(<p [^>]*>.*?<\/p>)|(<h\d[^>]*>.*?<\/h\d>)/m

  TAGREGEX = /<.*?>/
  BRREGEX = /<br>/
  NUMBERREGEX = /^\d[^\n]*/
  LINKREGEX = /(https[^\n\s]*)/
  BLANKLINESREGEX = /[\n]+/
  SPECIALCHARACTERSREGEX1 = /[^a-zA-Z\s\d\.()]+/
  SPECIALCHARACTERSREGEX2 = /[\W]+/
  EDITREGEX = /edit/



  TIMEOUT = 3

  # Functions
  def self.errorHTTP link
    puts "--------------------------------------------------------------"
    puts "HTTP Error"
    puts "Could not access the following url: #{link}"
    puts "--------------------------------------------------------------"
  end

  def self.extractSODoc(html)
    # extract doc and clean it by using the doc regex
    doc = html.to_s.scan (Constants::STACKOVERFLOWREGEX)
    doc = doc.join"\n"
    # remove tags
    doc.to_s.gsub! Constants::TAGREGEX, ""
    # remove lines that starts with numbers
    doc.to_s.gsub! Constants::NUMBERREGEX, ""
    # remove links
    doc.to_s.gsub! Constants::LINKREGEX, ""
    # remove blank lines
    doc.to_s.gsub! Constants::BLANKLINESREGEX, "\n"
    # remove special characters
    doc.to_s.gsub! Constants::SPECIALCHARACTERSREGEX1, ""
    doc.to_s.gsub! Constants::SPECIALCHARACTERSREGEX2, " "
    return doc
  end

  def self.extractGenericDoc(html)
    # extract doc and clean it by using the doc regex
    doc = html.to_s.scan (Constants::GENERICREGEX)
    doc = doc.join"\n"
    # remove tags
    doc.to_s.gsub! Constants::TAGREGEX, ""
    # remove lines that starts with numbers
    doc.to_s.gsub! Constants::NUMBERREGEX, ""
    # remove links
    doc.to_s.gsub! Constants::LINKREGEX, ""
    # remove blank lines
    doc.to_s.gsub! Constants::BLANKLINESREGEX, "\n"
    # remove special characters
    doc.to_s.gsub! Constants::SPECIALCHARACTERSREGEX1, ""
    doc.to_s.gsub! Constants::SPECIALCHARACTERSREGEX2, " "
    # remove wiki edit
    doc.to_s.gsub! Constants::EDITREGEX, ""
    return doc
  end

end