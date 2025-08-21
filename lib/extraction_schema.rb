# frozen_string_literal: true

require 'ruby_llm'

class ExtractionSchema
  def self.fields
    {
      candidate_name: { type: :string, desc: "Full name of the candidate" },
      skills: { type: :array, desc: "List of technical skills and technologies" },
      years_experience: { type: :number, desc: "Total years of professional experience" },
      education: { type: :string, desc: "Educational background and degrees" },
      contact_info: { type: :string, desc: "Email, phone, or other contact information" },
      work_experience: { type: :array, desc: "List of previous work positions and companies" },
      current_role: { type: :string, desc: "Current or most recent job title" },
      location: { type: :string, desc: "Current location or willingness to relocate" },
      salary_expectations: { type: :string, desc: "Salary expectations or range if mentioned" },
      availability: { type: :string, desc: "Availability for interviews or start date" }
    }
  end
end
