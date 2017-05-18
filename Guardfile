# A sample Guardfile
# More info at https://github.com/guard/guard#readme

## Uncomment and set this to only include directories you want to watch
# directories %w(app lib config test spec features) \
#  .select{|d| Dir.exists?(d) ? d : UI.warning("Directory #{d} does not exist")}

## Note: if you are using the `directories` clause above and you are not
## watching the project directory ('.'), then you will want to move
## the Guardfile to a watched dir and symlink it back, e.g.
#
#  $ mkdir config
#  $ mv Guardfile config/
#  $ ln -s config/Guardfile .
#
# and, you'll have to watch "config/Guardfile" instead of "Guardfile"
require 'active_support/inflector'


    guard :rspec, cmd: "spring rspec", all_after_pass: false do

      require "guard/rspec/dsl"
      dsl = Guard::RSpec::Dsl.new(self)
      watch('config/routes.rb')

      # Feel free to open issues for suggestions and improvements

      # RSpec files
      rspec = dsl.rspec
      watch(rspec.spec_helper) { rspec.spec_dir }
      watch(rspec.spec_support) { rspec.spec_dir }
      watch(rspec.spec_files)

      # Ruby files
      ruby = dsl.ruby
      dsl.watch_spec_files_for(ruby.lib_files)

      # Rails files
      rails = dsl.rails(view_extensions: %w(erb haml slim))
      dsl.watch_spec_files_for(rails.app_files)
      dsl.watch_spec_files_for(rails.views)

      watch(rails.controllers) do |m|
        [
          rspec.spec.call("routing/#{m[1]}_routing"),
          rspec.spec.call("controllers/#{m[1]}_controller"),
          rspec.spec.call("acceptance/#{m[1]}")
        ]

      end

      # Rails config changes
      watch(rails.spec_helper)     { rspec.spec_dir }
      watch(rails.routes)          { "#{rspec.spec_dir}/routing" }
      watch(rails.app_controller)  { "#{rspec.spec_dir}/controllers" }


      # Capybara features specs
      watch(rails.view_dirs)     { |m| rspec.spec.call("features/#{m[1]}") }
      watch(rails.layouts)       { |m| rspec.spec.call("features/#{m[1]}") }

      # Turnip features and steps
      watch(%r{^spec/acceptance/(.+)\.feature$})
      watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$}) do |m|
        Dir[File.join("**/#{m[1]}.feature")][0] || "spec/acceptance"
      end

        # Custom Rails Tutorial specs
        watch(%r{^app/controllers/(.+)_(controller)\.rb$}) do |m|
          ["spec/routing/#{m[1]}_routing_spec.rb",
           "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb",
           "spec/acceptance/#{m[1]}_spec.rb",
           (m[1][/_pages/] ? "spec/requests/#{m[1]}_spec.rb" :
                             "spec/requests/#{m[1].singularize}_pages_spec.rb")]
        end
        watch(%r{^app/views/(.+)/}) do |m|
          (m[1][/_pages/] ? "spec/requests/#{m[1]}_spec.rb" :
                            "spec/requests/#{m[1].singularize}_pages_spec.rb")
        end
        watch(%r{^app/controllers/sessions_controller\.rb$}) do |m|
          "spec/requests/authentication_pages_spec.rb"
        end


end

guard :bundler do
  require 'guard/bundler'
  require 'guard/bundler/verify'
  helper = Guard::Bundler::Verify.new

  files = ['Gemfile']
  files += Dir['*.gemspec'] if files.any? { |f| helper.uses_gemspec?(f) }

  # Assume files are symlinked from somewhere
  files.each { |file| watch(helper.real_path(file)) }
end
