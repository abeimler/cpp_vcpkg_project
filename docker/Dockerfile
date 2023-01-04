## base image
FROM ubuntu:22.04 AS base

ARG setup_cpp_linux_version="0.24.1"

# add setup_cpp https://github.com/aminya/setup-cpp
ADD https://github.com/aminya/setup-cpp/releases/download/v${setup_cpp_linux_version}/setup_cpp_linux /setup_cpp_linux
RUN chmod +x /setup_cpp_linux

ARG compiler="gcc"
# install cmake, ninja, and ccache
RUN /setup_cpp_linux --compiler $compiler --llvm true --cmake true --ninja true --ccache true --cppcheck true --vcpkg true --conan true --task true
#RUN cp /root/.cpprc /root/.bashrc

WORKDIR /home/project
ENV PROJECT_DIR /home/project

CMD source ~/.cpprc
COPY ./docker/entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]


## build stage
FROM base as build
COPY . .
CMD  ["task", "build"]

## test stage
FROM build as test
CMD ["task", "test"]

## coverage stage
FROM test as coverage
CMD ["task", "coverage"]

## test stage (without sanitizer)
FROM build as test-without-sanitizer
CMD ["task", "test:without-sanitizer"]
