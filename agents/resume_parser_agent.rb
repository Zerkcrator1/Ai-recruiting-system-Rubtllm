class ResumeParserAgent < RubyLLM::Tool
  description "Parse the candidate resume and extract the information"
  param :resume, desc: "Path to the candidate resume"

  def execute(resume:)
    response = RubyLLM.chat.with_schema(ResumeSchema).ask("Extract the information from the resume:\n#{resume}")
    {
      file: resume,
      content: response.content
    }
  end
end