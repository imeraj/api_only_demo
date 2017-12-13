class APIConstraint
  attr_reader :version
  VENDOR_MIME = 'application/vnd.app.v%d+json'

  def initialize(options)
    @version = options.fetch(:version)
  end

  def matches?(request)
    request.headers[:accept].include?(VENDOR_MIME % @version)
  end

end
