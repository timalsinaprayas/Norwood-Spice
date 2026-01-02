# 🍛 Norwood Spice Restaurant - DevSecOps Deployment

A modern, secure restaurant website for Norwood Spice, featuring authentic Nepali and Indian cuisine. Built with TypeScript React frontend and Java Spring Boot backend, deployed on AWS following DevSecOps principles.

[![DevSecOps](https://img.shields.io/badge/DevSecOps-Enabled-blue)](https://github.com/timalsinaprayas/Norwood-Spice/actions)
[![Security Scan](https://img.shields.io/badge/Security-Trivy%20%26%20OWASP-green)](https://github.com/timalsinaprayas/Norwood-Spice/actions)
[![AWS](https://img.shields.io/badge/Deployed%20on-AWS-orange)](https://aws.amazon.com/)

## 🏗️ Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   GitHub Actions │    │      AWS        │    │    Users        │
│   CI/CD Pipeline │────▶     ECS        │────▶   Web Browser   │
│                 │    │   Fargate      │    │                 │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Security      │    │   Monitoring    │    │   Load         │
│   Scanning      │    │   & Logging     │    │   Balancing     │
│   (Trivy, OWASP)│    │   (CloudWatch)  │    │   (ALB + WAF)   │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## 📁 Project Structure

```
.
├── frontend/                 # React TypeScript application
│   ├── Dockerfile           # Multi-stage frontend container
│   ├── nginx.conf          # Nginx configuration with security
│   └── src/
│       ├── components/     # Reusable React components
│       ├── pages/          # Page components (Home, Menu, About)
│       └── App.tsx         # Main application component
├── backend/                 # Spring Boot Java application
│   ├── Dockerfile          # Multi-stage backend container
│   └── src/main/java/
│       └── com/norwoodspice/restaurant/
│           ├── controller/ # REST API controllers
│           ├── service/    # Business logic services
│           ├── repository/ # Data access layer
│           └── model/      # JPA entity models
├── infrastructure/          # AWS Infrastructure as Code
│   └── terraform/          # Terraform configuration
│       ├── main.tf         # AWS resources (VPC, ECS, ALB, WAF)
│       ├── variables.tf    # Infrastructure variables
│       └── terraform.tfvars # Default variable values
├── docker-compose.yml       # Local development setup
└── .github/workflows/       # CI/CD pipelines
    └── devsecops-pipeline.yml # DevSecOps workflow
```

## 🚀 Quick Start

### Local Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/timalsinaprayas/Norwood-Spice.git
   cd Norwood-Spice
   ```

2. **Start with Docker Compose**
   ```bash
   docker-compose up --build
   ```

   Access the application:
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:8080

### Manual Setup

#### Frontend
```bash
cd frontend
npm install
npm run dev
```

#### Backend
```bash
cd backend
mvn spring-boot:run
```

## 🔒 DevSecOps Features

### Security Scanning
- **Container Security**: Trivy vulnerability scanning
- **Dependency Analysis**: OWASP Dependency Check
- **Image Scanning**: ECR automated scanning
- **WAF Protection**: AWS WAF with managed rules

### Infrastructure Security
- **Network Isolation**: VPC with private/public subnets
- **IAM Roles**: Least privilege access controls
- **Security Groups**: Minimal required access
- **HTTPS Enforcement**: SSL/TLS encryption

### CI/CD Pipeline
- **Automated Testing**: Unit and integration tests
- **Security Gates**: Fail builds on vulnerabilities
- **Container Registry**: GitHub Container Registry
- **Blue-Green Deployment**: Zero-downtime updates

### Monitoring & Observability
- **CloudWatch Logs**: Centralized logging
- **Application Metrics**: Performance monitoring
- **Health Checks**: Automated health monitoring
- **Container Insights**: ECS monitoring

## 🛠️ Technologies

### Frontend
- **React 18** - UI framework
- **TypeScript** - Type safety
- **Vite** - Build tool
- **Nginx** - Production web server

### Backend
- **Java 17** - Runtime
- **Spring Boot 3.2.0** - Framework
- **Spring Data JPA** - Data access
- **H2 Database** - In-memory database

### Infrastructure
- **AWS ECS Fargate** - Container orchestration
- **AWS ECR** - Container registry
- **AWS ALB** - Load balancing
- **AWS WAF** - Web application firewall
- **Terraform** - Infrastructure as Code

### DevSecOps Tools
- **GitHub Actions** - CI/CD
- **Trivy** - Vulnerability scanning
- **OWASP Dependency Check** - Dependency analysis
- **Docker** - Containerization

## 🚀 Deployment

### Prerequisites

1. **AWS Account** with appropriate permissions
2. **GitHub Repository** with Actions enabled
3. **AWS CLI** configured locally

### Automated Deployment

1. **Set up AWS credentials in GitHub Secrets:**
   ```
   AWS_ACCESS_KEY_ID
   AWS_SECRET_ACCESS_KEY
   AWS_REGION
   ```

2. **Deploy Infrastructure:**
   ```bash
   cd infrastructure/terraform
   terraform init
   terraform apply
   ```

3. **Push to main branch** to trigger automatic deployment

### Manual Deployment

1. **Build and push Docker images:**
   ```bash
   # Frontend
   docker build -t norwoodspice/frontend ./frontend
   aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <account>.dkr.ecr.us-east-1.amazonaws.com
   docker tag norwoodspice/frontend:latest <account>.dkr.ecr.us-east-1.amazonaws.com/norwoodspice/frontend:latest
   docker push <account>.dkr.ecr.us-east-1.amazonaws.com/norwoodspice/frontend:latest

   # Backend
   docker build -t norwoodspice/backend ./backend
   docker tag norwoodspice/backend:latest <account>.dkr.ecr.us-east-1.amazonaws.com/norwoodspice/backend:latest
   docker push <account>.dkr.ecr.us-east-1.amazonaws.com/norwoodspice/backend:latest
   ```

2. **Update ECS services** to use new images

## 🔍 Monitoring

### Application Logs
```bash
# View frontend logs
aws logs tail /ecs/norwoodspice/frontend --follow

# View backend logs
aws logs tail /ecs/norwoodspice/backend --follow
```

### Health Checks
- **Frontend**: http://your-domain/
- **Backend**: http://your-domain:8080/actuator/health

### Metrics Dashboard
Access CloudWatch dashboard for:
- CPU/Memory utilization
- Request latency
- Error rates
- Container insights

## 🛡️ Security

### Container Security
- Non-root user execution
- Minimal base images
- Security headers in Nginx
- Regular vulnerability scanning

### Network Security
- VPC isolation
- Security groups
- WAF protection
- SSL/TLS encryption

### Access Control
- IAM roles with least privilege
- GitHub Actions OIDC
- Secrets management
- Audit logging

## 📊 Performance

### Optimization Features
- Multi-stage Docker builds
- CDN-ready static assets
- Database connection pooling
- Caching headers
- Gzip compression

### Scaling
- Auto-scaling based on CPU/memory
- Load balancing across AZs
- Spot instances for cost optimization
- Horizontal pod scaling

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make changes with tests
4. Run security scans locally
5. Submit a pull request
6. CI/CD pipeline will validate changes

## 📝 API Documentation

### Endpoints

- `GET /api/menu` - Get all menu items
- `GET /api/menu/{id}` - Get menu item by ID
- `GET /actuator/health` - Health check

### Menu Item Structure
```json
{
  "id": 1,
  "name": "Chicken Tikka Masala",
  "description": "Tender chicken in creamy tomato sauce",
  "price": 15.99,
  "imageUrl": "https://...",
  "category": "Main Course",
  "isSpecial": true
}
```

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Inspired by authentic Nepali and Indian cuisine
- Built with modern DevSecOps practices
- Deployed on AWS cloud infrastructure

---

**🍛 Enjoy your meal at Norwood Spice!**

