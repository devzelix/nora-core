# Nora Core 🚀

Nora Core proporciona un entorno de desarrollo robusto y versionable para la automatización de flujos de trabajo con **n8n**, utilizando **PostgreSQL** como base de datos y **Docker** para una gestión de entorno consistente.

Este proyecto está diseñado con un enfoque de "GitOps", permitiendo que los flujos de trabajo (workflows) y credenciales de n8n sean exportados a formato JSON y versionados en Git de una manera controlada a través de scripts especializados.

---

## 📝 Tabla de Contenidos

*   [Prerrequisitos](#-prerrequisitos)
*   [Configuración Inicial](#-configuración-inicial)
*   [Uso Diario](#-uso-diario)
*   [Backup y Restauración de Workflows](#-backup-y-restauración-de-workflows)
*   [Variables de Entorno](#-variables-de-entorno)
*   [Estructura del Proyecto](#-estructura-del-proyecto)
*   [Detener los Servicios](#-detener-los-servicios)

---

## ⚙️ Prerrequisitos

Asegúrate de tener el siguiente software instalado en tu sistema:

*   [**Docker**](https://docs.docker.com/get-docker/) y [**Docker Compose**](https://docs.docker.com/compose/install/) (Normalmente incluido en Docker Desktop).
*   **Git**

---

## 🚀 Configuración Inicial

Sigue estos pasos para poner en marcha el proyecto:

### 1. Clonar el Repositorio

```bash
git clone <URL_DE_TU_REPOSITORIO>
cd nora-core
```

### 2. Crear el Archivo de Entorno

Crea tu archivo local `.env` a partir de la plantilla. Este archivo contendrá todas tus claves y configuraciones secretas y no será subido a Git.

```bash
# En Windows (Command Prompt)
copy .env.template .env

# En Windows (PowerShell)
cp .env.template .env

# En Linux o macOS
cp .env.template .env
```

### 3. Configurar las Variables de Entorno

Abre el archivo `.env` y rellena **todas** las variables. Presta especial atención a la `N8N_ENCRYPTION_KEY`.

**🔑 ¡MUY IMPORTANTE!** La `N8N_ENCRYPTION_KEY` es crítica para la seguridad de n8n. Úsala para encriptar datos sensibles como las credenciales. Genera una clave segura y guárdala en un lugar secreto. Si la pierdes, n8n no podrá leer tus credenciales.

Puedes generar una clave segura con comandos como:
`openssl rand -base64 32`

### 4. Iniciar los Servicios

Desde la raíz del proyecto, ejecuta Docker Compose para construir e iniciar los contenedores de PostgreSQL y n8n en segundo plano.

```bash
docker-compose up -d
```

La primera vez que se inicie, el contenedor de PostgreSQL ejecutará automáticamente los scripts que encuentre en `init-scripts` para configurar la base de datos `n8n_db`.

---

## 🌐 Uso Diario

Una vez que los servicios estén en ejecución, puedes acceder a la interfaz de n8n en tu navegador:

*   **URL de n8n:** `http://localhost:5678`
*   **Usuario:** `nora_admin` (o el que definas en `.env`)
*   **Contraseña:** `Nora112025` (o la que definas en `.env`)

---

## ✨ Backup y Restauración de Workflows

Este proyecto utiliza un sistema de scripts para gestionar la exportación e importación de workflows y credenciales, moviéndolos entre el directorio de trabajo de n8n (`data/n8n_local_data`, no versionado) y el directorio de backup (`git_backup`, versionado en Git).

### Exportar (Hacer un Backup)

Después de crear o modificar workflows en la interfaz de n8n, ejecuta el script de exportación para guardarlos en Git. Esto copiará los archivos `.json` relevantes al directorio `git_backup`.

*   **En Windows (PowerShell):**
    ```powershell
    .\scripts\git_export.ps1
    ```
*   **En Linux o macOS:**
    ```bash
    ./scripts/git_export.sh
    ```

Después de exportar, revisa los cambios con `git status` y crea un commit para guardar tus workflows en el historial del repositorio.

### Importar (Restaurar un Backup)

Si clonas el repositorio en una máquina nueva o cambias de rama y necesitas cargar los workflows versionados en n8n, ejecuta el script de importación **antes** de iniciar los contenedores.

*   **En Windows (PowerShell):**
    ```powershell
    .\scripts\git_import.ps1
    ```
*   **En Linux o macOS:**
    ```bash
    ./scripts/git_import.sh
    ```
---

## 🔑 Variables de Entorno

Descripción de las variables en el archivo `.env.template`:

| Variable                  | Descripción                                                                 |
| ------------------------- | --------------------------------------------------------------------------- |
| `DB_USER`                 | Nombre de usuario para la base de datos PostgreSQL.                         |
| `DB_PASSWORD`             | Contraseña para el usuario de PostgreSQL.                                   |
| `DB_NAME`                 | Nombre de la base de datos PostgreSQL principal.                            |
| `N8N_ENCRYPTION_KEY`      | **La clave más importante.** Única y secreta para encriptar credenciales.     |
| `N8N_BASIC_AUTH_ACTIVE`   | Activa (`true`) o desactiva (`false`) la autenticación básica de n8n.         |
| `N8N_BASIC_AUTH_USER`     | Nombre de usuario para el login de n8n.                                     |
| `N8N_BASIC_AUTH_PASSWORD` | Contraseña para el login de n8n.                                            |
| `GENERIC_TIMEZONE`        | Zona horaria para los contenedores (ej. `America/Caracas`).                 |
| `TZ`                      | Alias para `GENERIC_TIMEZONE`, asegura consistencia.                        |

---

## 📂 Estructura del Proyecto

```
.
├── .env                  # Archivo local con secretos (Ignorado por Git)
├── .env.template         # Plantilla para el archivo .env
├── .gitignore            # Archivos y directorios ignorados por Git
├── docker-compose.yml    # Define los servicios de Docker (Postgres y n8n)
├── README.md             # Este archivo de documentación
├── data/                 # Datos de tiempo de ejecución (Ignorado por Git)
│   ├── n8n_local_data/   # Directorio de trabajo de n8n (workflows, credenciales, etc.)
│   └── postgres_data/    # Archivos de la base de datos PostgreSQL
├── git_backup/           # Directorio para backups de workflows y credenciales (Versionado en Git)
│   ├── credentials/
│   └── workflows/
├── init-scripts/         # Scripts que se ejecutan al crear la base de datos por primera vez
│   └── create_n8n_db.sh
└── scripts/              # Scripts para la gestión de backups
    ├── git_export.ps1    # (PowerShell) Exporta workflows a git_backup/
    ├── git_export.sh     # (Bash) Exporta workflows a git_backup/
    ├── git_import.ps1    # (PowerShell) Importa workflows desde git_backup/
    └── git_import.sh     # (Bash) Importa workflows desde git_backup/
```
---

## 🛑 Detener los Servicios

Para detener todos los servicios de Docker asociados al proyecto:

```bash
docker-compose down
```
Esto parará y eliminará los contenedores, pero los datos en los volúmenes (`data/` y `git_backup/`) persistirán.
