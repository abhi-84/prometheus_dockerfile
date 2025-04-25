Use Dockerfile to create prometheusr v3.2.1 riscv docker image
# docker build -t prometheus_docker_image:v3.2.1 .
Save docker image to local disk in tar format
# docker save -o prometheus_image.tar prometheus_docker_image:v3.2.1
