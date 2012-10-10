require 'tilt'
require 'sprockets'
require 'css_splitter/application_helper'
require 'css_splitter/engine'
require 'css_splitter/splitter'
require 'css_splitter/version'

module CssSplitter
  module Sprockets
    class Template < ::Tilt::Template
      def self.engine_initialized?
        true
      end

      def initialize_engine
      end

      def prepare
      end

      def evaluate(scope, locals, &block)
        part = scope.pathname.extname =~ /(\d+)$/ && $1 || 0
        CssSplitter::Splitter.split data, part.to_i
      end
    end
  end
end

Sprockets::Engines
Sprockets.register_engine '.split2', CssSplitter::Sprockets::Template
