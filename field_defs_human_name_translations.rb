#we redefine human_name to pull from translations
if defined?(FieldDefs)
  FieldDefs.global_defaults do
    
    default_for_arg_type(:translation_full_key) do |field_defs|
      "activerecord.attributes.#{field_defs.for_model.to_s.underscore}.#{field_defs.translation_key.to_s}"
    end
    
    default_for_arg_type(:translation_key) do |field_defs|
      field_defs.field_name.to_s
    end
    
    default_for_arg_type(:human_name) do |field_defs|
      begin
        I18n.t(field_defs.translation_full_key, :raise => true)
      rescue I18n::MissingTranslationData => e
        field_defs.field_name.to_s.humanize
      end
    end
      
  end
end