FROM centos
WORKDIR /proxy
ADD . /proxy
RUN ["/bin/bash","docker_setup.sh"]
EXPOSE 1080 8118
CMD ["/bin/bash", "docker_start.sh"]



