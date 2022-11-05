FROM ubi/ubi7:7.9

ARG USERNAME
ARG USER_UID
ARG USER_GID=$USER_UID
ARG CERT_URL=http://config.objectstorage.cdc-west-2.devlnk.net/scripts/install-certs.sh
ARG REPO_URL=http://config.objectstorage.cdc-west-2.devlnk.net/scripts/install-repos.sh
# Install corporate certificates
RUN curl ${CERT_URL} | /bin/bash
RUN curl ${REPO_URL} | /bin/bash

# # install sudo.
# RUN yum update -y
# RUN yum install -y sudo
# # Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME
# # Add sudo support.
# RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
#     && chmod 0440 /etc/sudoers.d/$USERNAME

# Set the default user. Omit if you want to keep the default as root.
USER $USERNAME