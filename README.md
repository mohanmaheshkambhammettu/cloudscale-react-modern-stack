# AWS React Deployment Kit

This is a **beginner-friendly, end-to-end deployment kit** for hosting a React application using AWS services.

You will:
✅ Build and host a frontend (React) on **S3 + CloudFront**  
✅ Run a backend (Node.js) on **ECS + Fargate**  
✅ Use **Docker** for containerization  
✅ Monitor logs in **CloudWatch**  
✅ Deploy everything via **Terraform**, **CloudFormation**, and **GitHub Actions**

---

## 🧰 Prerequisites
Before starting, please make sure you have:

- An AWS Account ([create one here](https://aws.amazon.com))
- AWS CLI installed: [Install Guide](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- Terraform installed: [Install Terraform](https://developer.hashicorp.com/terraform/downloads)
- Docker installed: [Install Docker](https://docs.docker.com/get-docker/)
- Node.js + npm installed: [Install Node.js](https://nodejs.org/en/download/)
- GitHub account (for CI/CD automation)

---

## 🏗️ Step-by-Step Instructions

### 1. Clone This Project
```bash
git clone https://github.com/your-username/aws-react-deployment-kit.git
cd aws-react-deployment-kit
```

---

### 2. Frontend Setup (React)
```bash
cd frontend
npm install
npm run build
```
This builds your React app into static files.

---

### 3. Backend Setup (Node.js)
```bash
cd ../backend
npm install
```

---

### 4. Deploy Static Website to S3 + CloudFront (Terraform)
```bash
cd ../terraform
terraform init
terraform apply
```
✅ This will:
- Create an S3 bucket
- Upload your React build
- Deploy it behind CloudFront CDN

Once it finishes, note the **CloudFront URL** — your app is now live!

---

### 5. Deploy Backend on ECS with Docker (CloudFormation)

1. Edit `cloudformation/ecs-setup.yaml`
   - Replace `<your-ecr-uri>`, subnet IDs, and security group

2. Package & Push Docker Image:
```bash
aws ecr create-repository --repository-name react-app
aws ecr get-login-password | docker login --username AWS --password-stdin <your-ecr-url>
docker build -t react-app docker/
docker tag react-app:latest <your-ecr-url>/react-app
docker push <your-ecr-url>/react-app
```

3. Deploy to ECS:
```bash
aws cloudformation deploy \
  --template-file cloudformation/ecs-setup.yaml \
  --stack-name ReactAppStack \
  --capabilities CAPABILITY_NAMED_IAM
```
✅ This runs your backend as a service in the cloud.

---

### 6. Set Up CI/CD with GitHub Actions

1. Push your code to GitHub
2. GitHub will automatically:
   - Build the image
   - Push to ECR
   - Deploy to ECS (via `deploy.yml`)

✅ Your code is now continuously deployed!

---

### 7. Monitor with CloudWatch Logs
Go to [CloudWatch Logs Console](https://console.aws.amazon.com/cloudwatch/home#logsV2:log-groups)
- Look for `/ecs/react-app`
- Check logs in real-time for your backend

---

## ✅ What You Learned
- Hosting static websites (S3, CloudFront)
- Deploying containers with ECS Fargate
- Using Docker to package frontend & backend
- Managing resources with Terraform and CloudFormation
- CI/CD via GitHub Actions
- Monitoring with CloudWatch

---

## 💡 Want More?
Add-on ideas:
- User Auth with **Cognito**
- Database with **DynamoDB**
- Notification with **SNS**
- Messaging with **SQS**
- Monitoring Dashboards in **CloudWatch**

Ask me to add any of these, and I’ll plug them in instantly. 🚀
