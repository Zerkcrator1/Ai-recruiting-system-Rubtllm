# AI Recruiting System

A streamlined Ruby-based AI recruiting system powered by RubyLLM and OpenRouter for intelligent resume analysis and candidate screening.

## 🚀 Quick Start

1. **Install dependencies:**
   ```bash
   bundle install
   ```

2. **Configure API keys:**
   ```bash
   cp env.example .env
   # Add your OPENROUTER_API_KEY
   ```

3. **Use programmatically:**
   ```ruby
   require_relative 'lib/ai_recruiting_system'
   
   app = AIRecruitingSystem.new
   result = app.parse_resume('resumes/candidate.txt')
   screening = app.screen_candidate_basic(result, job_requirements)
   ```

## ✨ Features

- **📄 Resume Analysis** - Parse .txt resume files with AI
- **🔍 Candidate Screening** - AI-powered screening against job requirements  
- **🎯 Job Matching** - Intelligent candidate-to-job matching with scores
- **🤖 RubyLLM Integration** - Advanced AI agents for comprehensive analysis
- **💾 Data Persistence** - Save all results as JSON files
- **🚀 Programmatic API** - Clean, simple methods for integration

## 📋 Programmatic Usage

```ruby
# Initialize the system
app = AIRecruitingSystem.new

# Parse a resume
resume_result = app.parse_resume('resumes/candidate.txt')

# Screen against job requirements
screening = app.screen_candidate_basic(resume_result, job_requirements)

# Generate interview questions
questions = app.generate_interview_questions(job_description, resume_result)

# Save results
app.save_results(data, "analysis_results")
```

## 🏗️ Architecture

```
lib/
├── services/        # Resume parsing and candidate screening
├── clients/         # AI API client (OpenRouter optimized)
└── ai_recruiting_system.rb    # Main application class
```

## 🤖 AI Integration

- **OpenRouter API** - Claude models for superior analysis
- **RubyLLM Tools** - RecruitingAnalyzer and InterviewGenerator
- **Optimized Prompts** - HR specialist system messages
- **Enhanced Scoring** - Multi-factor candidate evaluation

## 📄 File Support

- **Supported**: .txt files only (reliable across all systems)
- **Note**: Convert PDF/DOCX resumes to .txt format for processing

## ⚙️ Requirements

- Ruby 3.0+
- OpenRouter API key
- Dependencies: `ruby_llm`, `httparty`, `dotenv`, `json`

## 🎯 Perfect For

Developers and HR teams who need a clean, programmatic AI recruiting system - no CLI, just powerful methods for integration!