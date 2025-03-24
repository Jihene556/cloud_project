terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}
resource "docker_network" "vote_network" {
  name = "vote_network"
}
resource "docker_container" "redis" {
  name  = "redis"
  image = "redis:alpine"
  restart = "always"

  networks_advanced {
    name = docker_network.vote_network.name
  }
  volumes {
    host_path = "C:/Users/jihen/FiseA3/cloud/project-main/healthchecks"  # Chemin absolu vers le répertoire healthchecks
    container_path = "/healthchecks"
  }
  healthcheck {
    test     = ["CMD", "sh", "/healthchecks/redis.sh"]
    interval = "5s"
    timeout  = "5s"
    retries  = 2
  }

  ports {
    internal = 6379
    external = 6379
  }
}

resource "docker_container" "db" {
  name  = "db"
  image = "postgres:15-alpine"
  restart = "always"

  env = [
    "POSTGRES_USER=postgres",
    "POSTGRES_PASSWORD=postgres",
    "POSTGRES_DB=postgres"
  ]

  networks_advanced {
    name = docker_network.vote_network.name
  }

  
  volumes {
    host_path      = "C:/Users/jihen/FiseA3/cloud/project-main/healthchecks"
    container_path = "/var/lib/postgresql/project-main_db-data"
  }

  healthcheck {
    test     = ["CMD", "sh", "/healthchecks/postgres.sh"]
    interval = "5s"
    timeout  = "5s"
    retries  = 2
  }

  ports {
    internal = 5432
    external = 5432
  }
}

resource "docker_container" "vote1" {
  name  = "vote1"
  image = "project-main-vote1"
  restart = "always"

  env = [
    "REDIS_HOST=redis",
    "REDIS_PORT=6379"
  ]

  networks_advanced {
    name = docker_network.vote_network.name
  }

  ports {
    internal = 5000
    external = 5000
  }

  depends_on = [docker_container.redis]
}

resource "docker_container" "vote2" {
  name  = "vote2"
  image = "project-main-vote2"
  restart = "always"

  env = [
    "REDIS_HOST=redis",
    "REDIS_PORT=6379"
  ]

  networks_advanced {
    name = docker_network.vote_network.name
  }

  ports {
    internal = 5000
    external = 5001
  }

  depends_on = [docker_container.redis]
}

resource "docker_container" "vote3" {
  name  = "vote3"
  image = "project-main-vote3"
  restart = "always"

  env = [
    "REDIS_HOST=redis",
    "REDIS_PORT=6379"
  ]

  networks_advanced {
    name = docker_network.vote_network.name
  }

  ports {
    internal = 5000
    external = 5002
  }

  depends_on = [docker_container.redis]
}

resource "docker_container" "result" {
  name  = "result"
  image = "project-main-result"
  restart = "always"

  env = [
    "db_HOST=db",
    "db_PORT=5432"
  ]

  networks_advanced {
    name = docker_network.vote_network.name
  }

  ports {
    internal = 3000
    external = 3001
  }

  depends_on = [docker_container.db]
}
resource "docker_container" "nginx" {
  name  = "nginx"
  image = "project-main-nginx"
  restart = "always"

  networks_advanced {
    name = docker_network.vote_network.name
  }

  ports {
    internal = 80
    external = 80
  }

  depends_on = [docker_container.vote1,docker_container.vote2,docker_container.vote3]
}

resource "docker_container" "worker" {
  name     = "worker"
  image    = "project-main-worker"  # Nom de l'image locale
  restart  = "always"

  networks_advanced {
    name = docker_network.vote_network.name
  }

  depends_on = [docker_container.redis, docker_container.db]
}

resource "docker_container" "seed" {
  name     = "seed"
  image    = "project-main-seed"  # Nom de l'image locale
  restart  = "no"    # On n'a pas besoin que le service seed redémarre en permanence

  ports {
    internal = 8080
    external = 8080
  }

  networks_advanced {
    name = docker_network.vote_network.name
  }

  depends_on = [docker_container.nginx]
}
