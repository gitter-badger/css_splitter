module CssSplitter
  module Sprockets
    class Engine < ::Rails::Engine
      isolate_namespace CssSplitter

      config.to_prepare do
        ApplicationController.helper(CssSplitter::ApplicationHelper)
      end
    end
  end
end

