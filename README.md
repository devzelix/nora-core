# Nora Core 🚀



This repository contains the base configuration for the `nora-core` project. It leverages **n8n** for robust workflow automation and **PostgreSQL** as its reliable database backend. The entire setup is engineered for reproducibility using Docker and meticulously configured to enable seamless version control for all n8n workflows.

---

## 📝 Table of Contents

*   [Prerequisites](#-prerequisites)
*   [Setup and Configuration](#-setup-and-configuration)
*   [Usage](#-usage)
*   [n8n Workflow Version Control](#n8n-workflow-version-control)
*   [Project Structure](#-project-structure)
*   [Stopping Services](#-stopping-services)

---

## ⚙️ Prerequisites

Before you embark on setting up this project, ensure you have the following essential software installed on your system:

*   [**Docker**](https://docs.docker.com/get-docker/)
    *   _Platform for developing, shipping, and running applications in containers._
*   [**Docker Compose**](https://docs.docker.com/compose/install/)
    *   _A powerful tool for defining and running multi-container Docker applications. (Often conveniently bundled with Docker Desktop)._

---

## 🚀 Setup and Configuration

Follow these streamlined steps to effortlessly get the `nora-core` project up and running:

### 1. Clone the Repository

Begin by cloning this repository to your local machine and navigating into its directory:

```bash
git clone <YOUR_REPOSITORY_URL>
cd nora-core
```
*(Remember to replace `<YOUR_REPOSITORY_URL>` with the actual URL of your Git repository)*

### 2. Set Up Environment Variables

Create your local `.env` configuration file by copying the provided template. This file is crucial as it will securely store your environment-specific credentials and settings.

```bash
cp .env.template .env
```

Now, meticulously edit the newly created `.env` file and populate the variables with their respective values:

```ini
# --- PostgreSQL Database Configuration ---
DB_USER=norauser              # Username for the PostgreSQL database
DB_PASSWORD=norapassword      # Password for the PostgreSQL user
DB_NAME=noradb                # Name of the PostgreSQL database

# --- n8n Service Configuration ---
# ENCRYPTION KEY: Generate an exceedingly strong and unique key. ABSOLUTELY DO NOT SHARE IT!
# n8n critically depends on this key to encrypt sensitive data such as credentials.
# A robust key can be generated using a command like `openssl rand -base64 32` or similar secure methods.
N8N_ENCRYPTION_KEY=your_strong_encryption_key_here

# --- n8n Security Configuration ---
# This variable enhances security by preventing workflows from accessing environment variables
# defined in this .env file or on the host system.
# Set to `true` to block access, `false` to allow. It is highly recommended to keep this `true`.
N8N_BLOCK_ENV_ACCESS_IN_NODE=true
```
**🔑 IMPORTANT SECURITY NOTE:** The `N8N_ENCRYPTION_KEY` is paramount for the security of your n8n instance. Generate a highly secure key and ensure it is backed up in a supremely safe and secret location. **Loss or modification of this key will render n8n unable to decrypt any previously saved credentials and encrypted data.**

### 3. Start the Docker Services

From the project's root directory, execute the following command to gracefully build and launch both the PostgreSQL database and n8n services in the background:

```bash
docker-compose up -d
```

---

## 🌐 Usage

Once all services are actively running, you can readily access the intuitive n8n user interface via your preferred web browser:

*   **n8n UI:** `http://localhost:5678`

---

## ✨ n8n Workflow Version Control

This `nora-core` project is ingeniously configured to facilitate direct versioning of your n8n workflows and their associated credentials within Git:

*   **Automated File Saving:** The meticulously crafted `docker-compose.yml` configuration instructs n8n to automatically persist your workflows and credentials as human-readable `.json` files. These files will reside in designated local directories.

    **Note:** These directories (`data/n8n_local_data/workflows/` and `data/n8n_local_data/credentials/`) are created automatically by n8n upon its initial startup. They will not be present in the repository clone initially.

*   **Commit to Git:** After diligently creating new workflows or refining existing ones within the n8n UI, you will observe tangible changes in these `.json` files. It is imperative to `add` and `commit` these modifications to your Git repository (e.g., `git add . && git commit -m "feat: Implement new customer onboarding workflow"`).

*   **Seamless Restoration:** Should you clone this repository onto a new development machine and initiate Docker Compose, n8n will intelligently read these `.json` files, thereby automatically loading all your previously versioned workflows and credentials.

---

## 📂 Project Structure

A concise overview of the project's directory and file organization:

```
.
├── .env                  # Local environment variables (Explicitly Untracked by Git)
├── .env.template         # Template for .env (Tracked by Git)
├── .gitattributes        # Git attribute configurations (Tracked by Git)
├── .gitignore            # Git ignore rules (Tracked by Git)
├── docker-compose.yml    # Docker services definition (Tracked by Git)
└── data/                 # Container for service-related data (Mostly Untracked by Git)
    ├── n8n_local_data/   # n8n runtime data and configurations
    │   ├── workflows/    # <-- n8n Workflows reside here! (Tracked by Git)
    │   └── credentials/  # <-- n8n Credentials reside here! (Tracked by Git)
    └── postgres_data/    # PostgreSQL database files (Untracked by Git)
```

---

## 🛑 Stopping Services

To gracefully halt all actively running Docker services associated with this project:

```bash
docker-compose down
```

---

**⚠️ Proprietary Software Notice:** This software is confidential and proprietary. All rights are reserved. Unauthorized copying or distribution of this software, or any portion of it, is strictly prohibited.