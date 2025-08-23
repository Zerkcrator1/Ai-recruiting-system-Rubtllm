require 'ruby_llm'
require_relative '../lib/email_schema'

class EmailWritingAgent < RubyLLM::Tool
  description "Compare skills and experience of a candidate with the job description"
  param :candidate_resume, desc: "Candidate resume"
  param :job_description, desc: "Job description"

  def execute(candidate_resume:, job_description:)
    RubyLLM.chat.with_schema(MatchingSchema)
           .ask("Determine if the candidate is a good fit for this job:\n#{candidate_resume}\n#{job_description}")
           .content
  end
end