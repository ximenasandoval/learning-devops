FROM docker 

RUN apk add --no-cache \
        python3 \
        py3-pip \
        git \
        yq \
    && pip3 install --upgrade pip \
    && pip3 install --no-cache-dir \
        awscli \
    && rm -rf /var/cache/apk/*

ENTRYPOINT [ "sh" ]