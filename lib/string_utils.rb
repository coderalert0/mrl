class String
  def snakify
    gsub(/\W/, '_').downcase.underscore
  end
end
