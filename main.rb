# frozen_string_literal: true

require 'dotenv/load'
require 'ruby_llm'
require_relative 'agents/resume_parser_agent'
require_relative 'agents/candidate_matching_agent'

# STEP 1: CONFIGURE RUBYLLM
RubyLLM.configure do |config|
  config.openrouter_api_key = ENV.fetch('OPENROUTER_API_KEY')
  config.default_model = 'google/gemini-2.5-flash'
end

# STEP 2: READ RESUME AND JOB DESCRIPTION
resume = File.read('data/resume.txt')
job_description = File.read('data/job_description.txt')

# STEP 3: COORDINATOR HANDLES MULTIPLE AGENTS
coordinator = RubyLLM.chat.with_tools(ResumeParserAgent, CandidateMatchingAgent)
result = coordinator.ask("Output a score of candidate based on the job description and the candidate's resume: #{job_description} #{resume}")
  
puts result.content