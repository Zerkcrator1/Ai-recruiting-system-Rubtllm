# frozen_string_literal: true

require 'ruby_llm'
require 'ruby_llm/schema'

class ResumeSchema < RubyLLM::Schema
  string :candidate_name, description: "Full name of the candidate", required: true
  array :skills, of: :string, description: "List of technical skills and technologies", required: true
  number :years_experience, description: "Total years of professional experience", required: true

  array :education do
    object do
      string :school, description: "Name of the school or university"
      string :degree, description: "Degree or qualification obtained"
      string :start_date, description: "Start date of the education"
      string :end_date, description: "End date of the education"
    end
  end

  array :contact_info do
    object do
      string :email, description: "Email address of the candidate"
      string :phone, description: "Phone number of the candidate"
    end
  end

  array :work_experience do
    object do
      string :company, description: "Name of the company"
      string :title, description: "Job title or role"
      string :start_date, description: "Start date of the work experience"
      string :end_date, description: "End date of the work experience"
    end
  end
end
