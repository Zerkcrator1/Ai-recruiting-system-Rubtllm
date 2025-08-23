require 'ruby_llm'
require_relative '../lib/matching_schema'

class CandidateMatchingAgent < RubyLLM::Tool
  description "Send an email to the candidate if they are a good fit for the job"
  param :email, desc: "If the candidate is a good fit for the job, send an email to the candidate with the job description and the candidate's resume"

  def execute(email:)
    RubyLLM.chat.with_schema(MatchingSchema)
           .ask("Determine if the candidate is a good fit for this job:\n#{candidate_resume}\n#{job_description}")
           .content
  end
end