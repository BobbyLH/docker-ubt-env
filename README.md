# The build process

## please make sure the docker daemon had been installed in your computer

1. git clone git@github.com:BobbyLH/docker-ubt-env.git
2. cd ./ubuntu
3. docker image build -t env-ubt .
4. docker container run --rm -it env-ubt
