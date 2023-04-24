# This default may be swapped for any compatible base image
ARG BASE_IMAGE=amd64/ubuntu:18.04

# This buildpack is used for tool installation and user/directory setup
FROM containerbase/buildpack:3.17.4@sha256:dbcfcca7de096140389a21695976c0056b5adee5e494bfb6b537dee5c7384080 AS buildpack

FROM ${BASE_IMAGE} as base

# Image containing:
# base Ubuntu:18.04
# 1.  utility apps
# 2.  Java (17.0.3+7)
# 3.  Java (8.0.342+7)
# 4.  Java (11.0.13+8)
# 5.  Maven (3.6.3)
# 6.  Node.js (16.10.0)
# 7.  NPM (7.24.0)
# 8.  Yarn (1.22.17)
# 9.  Bower (1.8.13)
# 10. Gradle (7.3)
# 11. Gradle (6.9.1)
# 12. python 2.7 + 3.6 + pip + pip3 + pipenv
# 13. python 3.7
# 14. [optional] python 3.8
# 15. Poetry (python)
# 16. Ruby 2.7.5 + bundle 2.3.4, rbenv and ruby-build
# 17. Go (1.12.6)
# 18. Scala 2.13.5, Sbt 1.5.7
# 19. PHP (7.2)
# 20. Composer
# 21. PHP Plugins
# 22. Mix, Hex, Erlang and Elixir
# 23. Cocoapods (1.11.2)
# 24. R + Packrat
# 25. Haskel + Cabal
# 26. dotnet-sdk-2.2,dotnet cli and NuGet
# 27. Paket
# 28. Cargo

# The buildpack supports custom user
ARG USER_NAME=wss-scanner
ARG USER_ID=1000
ARG USER_HOME=/home/${USER_NAME}
ARG APT_HTTP_PROXY

# Set env and shell
ENV BASH_ENV=/usr/local/etc/env
SHELL ["/bin/bash" , "-c"]

# Set up buildpack
COPY --from=buildpack /usr/local/bin/ /usr/local/bin/
COPY --from=buildpack /usr/local/buildpack/ /usr/local/buildpack/
RUN install-buildpack


ENV DEBIAN_FRONTEND noninteractive
ENV LANGUAGE	en_US.UTF-8
ENV LANG    	en_US.UTF-8
ENV LC_ALL  	en_US.UTF-8

### Install wget, curl, git, unzip, gnupg, locales
RUN apt-get update && \
	apt-get -y install wget curl git unzip gnupg locales && \
	locale-gen en_US.UTF-8 && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /tmp/*


### copy folder
COPY docker-image/ /

RUN chmod 755 /start.sh
RUN chgrp -R 0 ${USER_HOME} && chmod -R g=u ${USER_HOME}

ENV SCM_SCANNER_HOME=/etc/usr/local/whitesource/scm-scanner
RUN chmod -R ugo+rw ${SCM_SCANNER_HOME}
ENV LOG4J_FORMAT_MSG_NO_LOOKUPS=true
### Switch User ###
ENV HOME ${USER_HOME}
WORKDIR ${USER_HOME}
USER ${USER_NAME}


EXPOSE 9393

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/start.sh"]
