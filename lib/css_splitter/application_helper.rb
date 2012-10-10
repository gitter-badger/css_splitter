module CssSplitter
  module ApplicationHelper
    def split_stylesheet_link_tag(*sources)
      original_sources = sources.dup

      options = sources.extract_options!
      sources.collect!{ |source| head, tail = source.split('.'); "#{head}_split2.#{Array.wrap(tail).join('.')}" }
      sources << options

      [
        stylesheet_link_tag(*original_sources),
        "<!--[if lte IE 9]>",
        stylesheet_link_tag(*sources),
        "<![endif]-->"
      ].join("\n").html_safe
    end
  end
end
