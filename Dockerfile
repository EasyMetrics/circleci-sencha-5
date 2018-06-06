FROM openjdk:8-jre-stretch AS extjs

ENV SENCHA_VER=5.1.3.61
ENV SENCHA_CHECKSUM=171ae9f69bde80f663778b68a59a72bb08c72758e7f366556c5f53adab18a6df
ENV SENCHA_FILE=SenchaCmd-${SENCHA_VER}-linux-x64.run
ENV PATH /usr/local/bin/Sencha/Cmd/${SENCHA_VER}/:$PATH

RUN curl --silent --url https://cdn.sencha.com/cmd/${SENCHA_VER}/${SENCHA_FILE}.zip --output /tmp/${SENCHA_FILE}.zip
RUN echo "${SENCHA_CHECKSUM} */tmp/${SENCHA_FILE}.zip" | sha256sum -c -

RUN cd /tmp && \
    unzip ${SENCHA_FILE}.zip && \
    rm ${SENCHA_FILE}.zip && \
    chmod +x ${SENCHA_FILE} && \
    /tmp/${SENCHA_FILE} --prefix /usr/local/bin/ --mode unattended && \
    rm ${SENCHA_FILE}

RUN chmod +x /usr/local/bin/Sencha/Cmd/${SENCHA_VER}/sencha

VOLUME [ "/code" ]

ENTRYPOINT [ "sencha" ]