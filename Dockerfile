FROM alpine:3.8 as sdk-download

COPY fetch-sdk.sh .
RUN ./fetch-sdk.sh

COPY fetch-repo.sh .
RUN ./fetch-repo.sh


FROM scratch as sdk

COPY --from=sdk-download /sdk /

# fix COPY permissions
RUN chmod +s /usr/bin/sudo
RUN chown -R chronos:chronos /home/chronos

COPY fetch-source.sh /usr/local/bin/
COPY setup-root.sh /usr/local/bin/

ENV PATH=$PATH:/opt/depot_tools:/home/chronos/trunk/chromite/bin

RUN echo "chronos ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER chronos
RUN git config --global user.email "dev@null"
RUN git config --global user.name "/dev/null"

CMD ["/bin/bash"]


FROM sdk as source

RUN fetch-source.sh
RUN sudo setup-root.sh

CMD ["/bin/bash"]
