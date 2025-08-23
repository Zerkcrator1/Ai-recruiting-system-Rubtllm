# frozen_string_literal: true

require 'ruby_llm'
require 'ruby_llm/schema'

class EmailSchema < RubyLLM::Schema
  boolean :is_good_fit, description: "Whether the candidate is a good fit for the job", required: true
end