# frozen_string_literal: true

require 'ruby_llm'
require 'json'
require_relative 'lib/email_schema'
require_relative 'lib/matching_schema'
require_relative 'lib/resume_schema'
require_relative 'agents/resume_parser_agent'
require_relative 'agents/candidate_matching_agent'
require_relative 'agents/email_writing_agent'

# STEP 1: CONFIGURE RUBYLLM
RubyLLM.configure do |config|
  config.openrouter_api_key = ENV['OPENROUTER_API_KEY']
  config.default_model = 'google/gemini-2.5-flash'
end

# STEP 2: READ RESUME AND JOB DESCRIPTION
resume = File.read('data/resume.json')
job_description = File.read('data/job_description.json')

# STEP 3: COORDINATOR HANDLES MULTIPLE AGENTS
coordinator = RubyLLM.chat.with_tools(ResumeParserAgent, CandidateMatchingAgent)
result = coordinator.ask("Output a score of candidate based on the job description and the candidate's resume: #{job_description} #{resume}")
  
# STEP 4: CONTACT CANDIDATE
email = RubyLLM.chat.with_tools(ResumeParserAgent, EmailSchema).ask("Extract the email address from the resume: #{resume}")
message = coordinator.ask("If the candidate is a good fit for the job, send an email to the candidate with the job description and the candidate's resume: #{job_description} #{resume}")

puts result.content

puts email.content
