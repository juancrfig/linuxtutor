# Lab 01: Broken Dockerfile

**Difficulty:** ⭐⭐  
**Time:** 15-20 minutes  
**Topics:** Dockerfile best practices, security, build optimization

## Scenario

A junior developer wrote this Dockerfile. It "works" but has 8+ problems that will cause issues in production. Your job: find and fix every issue.

## Tasks

**Task 1:** Try to build the image. It will fail. Why? Fix it.

**Task 2:** Once it builds, identify all the bad practices:
- Security issues
- Build optimization problems
- Missing best practices
- Maintainability issues

**Task 3:** Rewrite the Dockerfile following best practices. Your fixed version should:
- Use a specific base image version
- Run as non-root user
- Have proper WORKDIR
- Copy files efficiently (leverage layer caching)
- Be production-ready

**Task 4:** Create a `.dockerignore` file to exclude unnecessary files.

## Self-Check

Your fixed Dockerfile should have:
- ✅ Specific version tag (not `latest`)
- ✅ WORKDIR defined
- ✅ package.json copied before app code (caching)
- ✅ Non-root USER
- ✅ EXPOSE directive
- ✅ exec form CMD
- ✅ .dockerignore created

Build both versions and compare sizes. Fixed version should be similar or smaller.

## Hints

<details>
<summary>Issues in the original (click to reveal)</summary>

1. `latest` tag — not reproducible
2. Missing WORKDIR
3. npm install before package.json copy — breaks caching
4. No package.json copy at all!
5. Running as root
6. No EXPOSE
7. Shell form CMD instead of exec form
8. No .dockerignore
9. Installing in wrong order

</details>
