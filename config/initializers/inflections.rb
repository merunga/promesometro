ActiveSupport::Inflector.inflections do |inflect|
  inflect.plural /([taeiou])([A-Z]|\$)/, '\1s\2'
  inflect.plural /([rlnd])([A-Z]|$)/, '\1es\2'
  inflect.singular /([taeiou])s([A-Z]|$)/, '\1\2'
  inflect.singular /([rlnd])es([A-Z]|$)/, '\1\2'
end

# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format
# (all these examples are active by default):
# ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end
#
# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections do |inflect|
#   inflect.acronym 'RESTful'
# end