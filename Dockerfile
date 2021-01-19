FROM golang:latest

# Update packages
RUN apt-get -y update && apt-get -y dist-upgrade && \
    apt-get -y install curl gnupg build-essential git less nano default-jdk

# Install Google Cloud SDK
RUN curl https://sdk.cloud.google.com > install.sh
RUN bash install.sh --disable-prompts
ENV PATH=${PATH}:/root/google-cloud-sdk/bin:/usr/local/go/bin
RUN gcloud components update && gcloud components install app-engine-go && \
    gcloud components install cloud-datastore-emulator
RUN rm install.sh

# Install Node
RUN curl -sL https://deb.nodesource.com/setup_15.x | bash - && \
    apt-get -y install nodejs

# Installing necessary npm packages
RUN npm -g config set user root

# Always update NPM just in case the bundled version of NPM is somehow
# outdated
RUN npm -g i npm
RUN npm -g i yarn firebase-tools
