# Claude API Multi-Agent Workflow Project

## Project Overview
This workspace contains a comprehensive Claude API multi-agent workflow system with real-time token tracking, parallel execution capabilities, and VS Code integration.

## Architecture
- **Multi-Agent System**: Orchestrator pattern with specialized agents (researcher, coder, analyst, writer)
- **Parallel Execution**: Simultaneous agent execution using Promise.all()
- **Token Monitoring**: Real-time token usage tracking and cost calculation
- **VS Code Integration**: Tasks, settings, and extension support

## Key Features
- Real-time token usage tracking with cost calculation
- Parallel and sequential agent execution modes
- Configurable agent roles and system prompts
- Error handling with retry mechanisms
- Rate limiting and budget controls
- CLI commands and VS Code tasks integration

## Development Guidelines
- Use environment variables for API keys and configuration
- Implement proper error handling and retry logic
- Monitor token usage and costs in real-time
- Follow the agent orchestrator pattern for complex workflows
- Use parallel execution for independent tasks
- Implement rate limiting for API calls

## Current Status
✅ Project structure initialized
⏳ Setting up core components...