# frozen_string_literal: true

require 'dotenv/load'
require 'ruby_llm'
require 'async'
require_relative 'lib/extraction_schema'
require_relative 'lib/csv_exporter'

# STEP 1: CONFIGURE RUBYLLM

RubyLLM.configure do |config|
  config.openrouter_api_key = ENV.fetch('OPENROUTER_API_KEY', nil)
end

# STEP 2: EXTRACT INFORMATION FROM RESUMES

# Get all candidates files from the resumes directory
candidates_files = Dir.glob('resumes/*.json')

puts "Found #{candidates_files.length} candidates(s) to process"

# Process all resumes using async
results = Async do
  tasks = candidates_files.map do |file_path|
    Async do
      puts "Processing #{File.basename(file_path)}..."
      chat = RubyLLM.chat(model: 'meta-llama/llama-3.2-3b-instruct')
      response = chat.with_schema(ExtractionSchema).ask('Extract the information from the resume, including candidate name, skills, total years of experience, education, contact information, and work experience', with: file_path)
      {
        file: file_path,
        content: response.content
      }
    end
  end

  # Wait for all tasks and return results
  tasks.map(&:wait)
end.result

puts "Finished processing #{results.length} candidates(s)"

all_extractions = results.flat_map do |result|
  content = result[:content]
  content.is_a?(Array) ? content : [content]
end

# STEP 3: COMPARE CANDIDATES WITH JOB DESCRIPTION

class WriterAgent < RubyLLM::Tool
  description "Compare skills and experience of a candidate with the job description"
  param :research, desc: "Compare skills to job description"

  def execute(research:)
    RubyLLM.chat(model: 'meta-llama/llama-3.2-3b-instruct')
           .ask("Compare skills and experience of a candidate with the job description:\n#{research}")
           .content
  end
end

# Coordinator uses both tools
coordinator = RubyLLM.chat.with_tools(ResearchAgent, WriterAgent)
article = coordinator.ask("Output a score of candidate based on the job description and the candidate's resume")
output_file = 'outputs/resume_response.csv'