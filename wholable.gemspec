# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "wholable"
  spec.version = "1.5.0"
  spec.authors = ["Brooke Kuhlmann"]
  spec.email = ["brooke@alchemists.io"]
  spec.homepage = "https://alchemists.io/projects/wholable"
  spec.summary = "A whole value object enabler."
  spec.license = "Hippocratic-2.1"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/bkuhlmann/wholable/issues",
    "changelog_uri" => "https://alchemists.io/projects/wholable/versions",
    "documentation_uri" => "https://alchemists.io/projects/wholable",
    "funding_uri" => "https://github.com/sponsors/bkuhlmann",
    "label" => "Wholable",
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/bkuhlmann/wholable"
  }

  spec.signing_key = Gem.default_key_path
  spec.cert_chain = [Gem.default_cert_path]

  spec.required_ruby_version = "~> 3.3"

  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.files = Dir["*.gemspec", "lib/**/*"]
end
