# Contributing to Restaurant Application

Thank you for your interest in contributing! This document provides guidelines and information for contributors.

## Development Setup

### Prerequisites
- Docker and Docker Compose
- Node.js 20+ (for frontend development)
- JDK 17+ (for backend development)
- AWS CLI (for deployment)

### Local Development
```bash
# Clone the repository
git clone https://github.com/your-org/restaurant-app.git
cd restaurant-app

# Start development environment
docker-compose up --build

# Frontend will be available at http://localhost:3000
# Backend will be available at http://localhost:8080
```

## Development Workflow

### 1. Create a Feature Branch
```bash
git checkout -b feature/your-feature-name
```

### 2. Make Your Changes
- Follow the existing code style
- Write tests for new functionality
- Update documentation as needed
- Ensure all security checks pass

### 3. Security Requirements
All contributions must pass the following security checks:

#### Code Quality
- **Linting**: Run `npm run lint` in frontend directory
- **Type Checking**: Ensure TypeScript compilation succeeds
- **Testing**: Maintain >80% code coverage

#### Security Scanning
- **SAST**: CodeQL security analysis
- **Dependency Scanning**: Automated via Dependabot
- **Container Scanning**: Trivy vulnerability scans
- **Secrets Detection**: Gitleaks prevents secret commits

### 4. Commit Your Changes
```bash
git add .
git commit -m "feat: add your feature description

- What was changed
- Why it was changed
- How to test the change"
```

### 5. Create a Pull Request
- Push your branch to GitHub
- Create a pull request with a clear description
- Request review from maintainers
- Address any review feedback

## Pull Request Requirements

### Title Format
Use conventional commit format:
- `feat:` - New features
- `fix:` - Bug fixes
- `docs:` - Documentation changes
- `refactor:` - Code refactoring
- `test:` - Testing changes
- `security:` - Security-related changes

### Description Template
```markdown
## Description
Brief description of the changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update
- [ ] Security enhancement

## Security Impact
- [ ] No security impact
- [ ] Security enhancement
- [ ] Requires security review

## Testing
- [ ] Unit tests added/updated
- [ ] Integration tests added/updated
- [ ] Manual testing completed
- [ ] Security testing completed

## Checklist
- [ ] Code follows style guidelines
- [ ] Documentation updated
- [ ] Tests pass
- [ ] Security scans pass
- [ ] Ready for review
```

## Security Considerations

### For All Changes
- [ ] No secrets or credentials committed
- [ ] Input validation implemented
- [ ] Authentication/authorization properly handled
- [ ] HTTPS used for all external communications
- [ ] Sensitive data encrypted

### For Backend Changes
- [ ] SQL injection prevention
- [ ] XSS protection
- [ ] CSRF protection
- [ ] Rate limiting implemented
- [ ] Proper error handling (no sensitive info leaked)

### For Frontend Changes
- [ ] Content Security Policy compliant
- [ ] XSS protection via React
- [ ] Secure cookie handling
- [ ] Input sanitization

### For Infrastructure Changes
- [ ] Least privilege principle followed
- [ ] Network segmentation implemented
- [ ] Encryption at rest and transit
- [ ] Monitoring and logging configured

## Code Review Process

### Automated Checks
All PRs must pass:
- GitHub Actions CI/CD pipeline
- CodeQL security analysis
- Trivy vulnerability scanning
- Test coverage requirements

### Manual Review
PRs will be reviewed for:
- Code quality and style
- Security implications
- Performance impact
- Documentation completeness
- Test coverage

### Approval Requirements
- At least 1 maintainer approval
- All automated checks passing
- Security review for security-related changes

## Release Process

### Versioning
We use [Semantic Versioning](https://semver.org/):
- **MAJOR**: Breaking changes
- **MINOR**: New features
- **PATCH**: Bug fixes

### Release Checklist
- [ ] All tests passing
- [ ] Security scans clean
- [ ] Documentation updated
- [ ] Changelog updated
- [ ] Deployment to staging successful
- [ ] Manual testing completed
- [ ] Stakeholder approval obtained

## Getting Help

- **Documentation**: Check the `/docs` directory
- **Issues**: Use GitHub issues for bugs and feature requests
- **Discussions**: Use GitHub discussions for questions
- **Security**: See `SECURITY.md` for security-related concerns

Thank you for contributing to make our restaurant application more secure and reliable! 🛡️
