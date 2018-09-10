module Amazon

  # Simple service class to construct a Nokigir DOM object for an HTML page
  class Page

    def self.call(body)
      Nokogiri::HTML(body, Encoding::UTF_8.to_s)
    end

  end

end
