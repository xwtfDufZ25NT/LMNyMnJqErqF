FROM alpine:3.5
COPY csteps /usr/local/bin/
RUN csteps 1
RUN csteps 2
WORKDIR /tmp/app
RUN csteps 3
RUN csteps 4
WORKDIR /
RUN csteps 5
CMD /run.sh