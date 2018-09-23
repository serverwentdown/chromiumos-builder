FROM alpine:3.8 as sdk-download

COPY fetch-sdk.sh .
RUN ./fetch-sdk.sh

COPY fetch-repo.sh .
RUN ./fetch-repo.sh

FROM scratch as sdk

COPY --from=sdk-download /sdk /
ENV PATH=$PATH:/opt/depot_tools

# fix permissions
RUN chmod +s /usr/bin/sudo
RUN mkdir -p /chromiumos
RUN chown -R chronos:chronos /chromiumos
RUN chown -R chronos:chronos /home/chronos

COPY fetch-source.sh /usr/local/bin/
COPY full-build.sh /usr/local/bin/

RUN echo "chronos ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER chronos
RUN git config --global user.email "dev@null"
RUN git config --global user.name "/dev/null"

WORKDIR /chromiumos

CMD ["/bin/bash"]

FROM sdk as source

RUN fetch-source.sh

# Add chromite/bin into the user's path
ENV PATH=$PATH:/chromiumos/chromite/bin
# Add chromite as a local site-package
RUN mkdir -p /home/chronos/.local/lib/python2.6/site-packages
RUN ln -s /chromiumos/chromite /home/chronos/.local/lib/python2.6/site-packages/
ENV PORTAGE_USERNAME=chronos
# Add bash completion
RUN echo ". /chromiumos/src/scripts/bash_completion" >> .bash_profile

WORKDIR /chromiumos/src/scripts
