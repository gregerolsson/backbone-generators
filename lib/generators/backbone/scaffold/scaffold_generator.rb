module Backbone
  module Generators
    class ScaffoldGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      argument :name, :type => :string

      def create_templates
        template 'index.hbs.erb', "app/templates/#{pluralized}/index.hbs"
        template 'item.hbs.erb', "app/templates/#{pluralized}/item.hbs"
        template 'show.hbs.erb', "app/templates/#{pluralized}/show.hbs"
      end

      def create_styles
        template 'index.scss.erb', "app/stylesheets/#{pluralized}/index.scss"
        template 'item.scss.erb', "app/stylesheets/#{pluralized}/item.scss"
        template 'show.scss.erb', "app/stylesheets/#{pluralized}/show.scss"
      end

      def create_views
        template 'index.js.erb', "public/javascripts/app/views/#{pluralized}/index.js"
        template 'item.js.erb', "public/javascripts/app/views/#{pluralized}/item.js"
        template 'show.js.erb', "public/javascripts/app/views/#{pluralized}/show.js"
      end

      def create_model
        template 'model.js.erb', "public/javascripts/app/models/#{name.underscore.gsub('_', '-')}.js"
      end

      def create_controller
        template 'controller.js.erb', "public/javascripts/app/controllers/#{pluralized}-controller.js"
      end

    private

      def pluralized
        @pluralized ||= name.underscore.pluralize.gsub('_', '-')
      end

      def namespace
        @namespace ||= name.pluralize
      end

      def model_class
        @model_class ||= name.constantize
      end

      def integer_columns
        model_class.columns.reject { |c|
          c.type != :integer or c.name == 'id' or c.name.end_with? '_id' or c.name.end_with? '_count'
        }
      end

      def validators
        model_class.validators.select { |validator|
          validator.kind == :presence || validator.kind == :length
        }
      end

      def associations
        model_class.reflect_on_all_associations.select { |assoc|
          assoc.macro == :has_many && assoc.options[:dependent] && !(exceptions[model_class] == assoc.name)
        }
      end

      def index_template_name
        "#{pluralized}-index-hbs"
      end

      def item_template_name
        "#{pluralized}-item-hbs"
      end

      def show_template_name
        "#{pluralized}-show-hbs"
      end
    end
  end
end