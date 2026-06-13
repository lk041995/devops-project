# DevOps Jenkins CI Demo

A minimal static web site (HTML + CSS) used to test a Jenkins CI/CD pipeline
with Docker. No Node.js or build tools required.

## Files

| File           | Purpose                                          |
|----------------|--------------------------------------------------|
| `index.html`   | The web page                                     |
| `style.css`    | Page styling                                     |
| `test.sh`      | Smoke tests (run in the CI `Test` stage)         |
| `Dockerfile`   | Builds an nginx image serving the site           |
| `Jenkinsfile`  | Declarative Jenkins pipeline                     |

## Run locally with Docker

```bash
docker build -t devops-ci-demo .
docker run -d -p 8080:80 devops-ci-demo
```

Then open http://localhost:8080

## Run the tests

```bash
bash test.sh
```

## Jenkins pipeline stages

1. **Checkout** – pulls the repo
2. **Test** – runs `test.sh` smoke tests
3. **Build Image** – builds the Docker image
4. **Deploy** – runs the container on port 8080
5. **Verify** – curls the running site

## Jenkins setup

1. Push this project to a Git repo (GitHub/GitLab).
2. In Jenkins: **New Item → Pipeline** (or **Multibranch Pipeline**).
3. Under *Pipeline*, choose **Pipeline script from SCM**, set your repo URL,
   and keep the script path as `Jenkinsfile`.
4. The Jenkins agent needs **Docker** and **curl** installed.
5. Click **Build Now**.
