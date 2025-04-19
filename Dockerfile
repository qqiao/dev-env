FROM golang:latest

# Update packages
RUN apt-get -y update && apt-get -y dist-upgrade && \
    apt-get -y install curl gnupg build-essential git less nano default-jdk

# Install Google Cloud SDK
ENV PATH=${PATH}:/root/google-cloud-sdk/bin:/usr/local/go/bin
RUN curl https://sdk.cloud.google.com > install.sh && \
    bash install.sh --disable-prompts && \
    gcloud components update && gcloud components install app-engine-go && \
    gcloud components install cloud-datastore-emulator && rm install.sh

# Install Node
RUN curl -sL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get -y install nodejs

# Installing necessary npm packages
# Always update NPM just in case the bundled version of NPM is somehow
# outdated
RUN npm -g i npm && npm i -g npm && npm -g i yarn firebase-tools
