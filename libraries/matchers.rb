if defined?(ChefSpec)
  if ChefSpec.respond_to?(:define_matcher)
    ChefSpec.define_matcher :application_service
  end

  def create_application_service(name)
    ChefSpec::Matchers::ResourceMatcher.new(:application_service, :create, name)
  end

end
