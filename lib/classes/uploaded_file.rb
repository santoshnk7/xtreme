class UploadedFile < StringIO
  def initialize(content, filename, content_type)
    @original_filename = filename
    @filename = filename
    @content_type = content_type
    super(content)
  end

  def path
    ""
  end
end
