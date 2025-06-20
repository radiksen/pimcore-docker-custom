# Pimcore Docker Starter (Simple Apache)

This is a simple, ready-to-use Docker environment for local Pimcore development. This starter kit uses Docker Compose and includes a single container for Apache/PHP and a separate container for the MariaDB database.

## Features

-   **Docker Compose**: Simple two-container setup.
-   **Apache**: Web server configured for Pimcore.
-   **PHP**: Ready-to-use environment for running Pimcore.
-   **MariaDB 10.6**: Robust database for your data.
-   **Composer**: Ready to use inside the PHP container.

## Requirements

Make sure you have the following installed on your system:
-   [Docker](https://docs.docker.com/get-docker/)
-   [Docker Compose](https://docs.docker.com/compose/install/)

## Getting Started

Follow these steps to get your Pimcore instance up and running.

**1. Clone the Repository**
```bash
git clone [https://github.com/radiksen/pimcore-docker-custom.git](https://github.com/radiksen/pimcore-docker-custom.git)
cd pimcore-docker-custom


**2. Launch the Containers**

This command will build the Docker image and launch the containers in detached mode.

```bash

docker-compose up -d --build


**3. Install Pimcore Dependencies**

Run Composer install inside the running container to download all required PHP libraries.

Bash

docker-compose exec pimcore composer install


**4. Run the Pimcore Installer**

This command will install Pimcore using the credentials from docker-compose.yml and create an admin user for you.

(Replace admin and your_strong_password with your desired credentials)

```bash

docker-compose exec pimcore vendor/bin/pimcore-install \
  --admin-username admin \
  --admin-password your_strong_password \
  --mysql-host-socket db \
  --mysql-username pimcore \
  --mysql-password pimcore \
  --mysql-database pimcore

  Important: After installation, you might need to fix file permissions so Pimcore can write to the cache and logs.

```bash

sudo chown -R www-data:www-data pimcore/var pimcore/public/var

Important: After installation, you might need to fix file permissions so Pimcore can write to the cache and logs.

Bash

sudo chown -R www-data:www-data pimcore/var pimcore/public/var
