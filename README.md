# BOILERPLATE
My goal is to create the smallest possible production grade container images for the frameworks I use often.

This is an attempt to create a Dockerized Rails application with images as small as possible while still being secure. This will decrease build times, build minutes, surface attack area and same money. Also, developers will be less frustrated.

When this is complete it can be used as a boilerplate for Rails applications.

I chose to use Docker multi-stage builds to keep the code clean, easy to maintain and less confusing.

Currently using Alpine Linux, I may switch to NixOS in future if it's worth the effor and will make development easier or will greatly reduce the image size when compared to Alpine.

## Setup environment
* Start Docker and cry as it slowly uses every resource on your Mac and pray for better internet in South Africa.
* Create the environement variables and docker images:
  ```zsh
  cp .env.example .env
  docker compose build
  docker compose run --rm web bin/rails db:setup
  ```
  
## Run the app
```zsh
docker-compose up
```

![Images](public/screenshots/screenshot 2022-05-13 at 04.34.39.png?raw=true "Images")
![Volumes](public/screenshots/screenshot 2022-05-13 at 04.34.55.png?raw=true "Volumes")

### TODO:
- make Docker Compose use envirement variables
- minor optimizations
- create Github Actions
- pentest
- development Docker stage
- test Docker stage

Know how to make this better? Reach out!  
