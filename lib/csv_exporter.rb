# frozen_string_literal: true

require 'csv'

class CSVExporter
  def self.export_candidates(candidates, output_file)
    CSV.open(output_file, 'w', write_headers: true, headers: headers) do |csv|
      candidates.each do |candidate|
        csv << [
          candidate[:candidate_name],
          candidate[:skills]&.join(', '),
          candidate[:years_experience],
          candidate[:education],
          candidate[:contact_info],
          candidate[:work_experience]&.join('; '),
          candidate[:current_role],
          candidate[:location],
          candidate[:salary_expectations],
          candidate[:availability]
        ]
      end
    end
  end

  def self.export_comparison_results(results, output_file)
    CSV.open(output_file, 'w', write_headers: true, headers: comparison_headers) do |csv|
      results.each do |result|
        csv << [
          result[:candidate_name],
          result[:job_title],
          result[:match_score],
          result[:strengths],
          result[:weaknesses],
          result[:recommendation]
        ]
      end
    end
  end

  private

  def self.headers
    [
      'Candidate Name',
      'Skills',
      'Years Experience',
      'Education',
      'Contact Info',
      'Work Experience',
      'Current Role',
      'Location',
      'Salary Expectations',
      'Availability'
    ]
  end

  def self.comparison_headers
    [
      'Candidate Name',
      'Job Title',
      'Match Score',
      'Strengths',
      'Weaknesses',
      'Recommendation'
    ]
  end
end
