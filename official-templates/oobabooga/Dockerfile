# start from runpod pytorch container
ARG BASE_IMAGE
FROM ${BASE_IMAGE}

FROM ${BASE_IMAGE} as dev-base

ARG OOBABOOGA_REQUIREMENTS_FILE

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV DEBIAN_FRONTEND=noninteractive
ENV SHELL=/bin/bash

RUN apt-get update --yes && \
    apt-get upgrade --yes && \
    apt install --yes --no-install-recommends\
    wget\
    bash\
    rsync \
    openssh-server &&\
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN /usr/bin/python3 -m pip install --upgrade pip
RUN pip install jupyterlab
RUN pip install ipywidgets

RUN mkdir -p /workspace

RUN cd /workspace && git clone https://github.com/robert-werner/text-generation-webui.git && cd /workspace/text-generation-webui && pip install -r ${OOBABOOGA_REQUIREMENTS_FILE}
RUN cd /workspace/text-generation-webui && python download-model.py PygmalionAI/pygmalion-6b

# NGINX Proxy
COPY --from=proxy nginx.conf /etc/nginx/nginx.conf
COPY --from=proxy readme.html /usr/share/nginx/html/readme.html

# Copy the README.md
COPY README.md /usr/share/nginx/html/README.md

# Start Scripts
COPY pre_start.sh /pre_start.sh
COPY post_start.sh /post_start.sh
COPY --from=scripts start.sh /
RUN chmod +x /start.sh

CMD [ "/start.sh" ]
