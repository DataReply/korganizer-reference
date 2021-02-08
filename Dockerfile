FROM dtzar/helm-kubectl:3.5.0
ARG KUSTOMIZE_VERSION=3.8.2
ARG YQ_VERSION=3.4.1

WORKDIR /korgi
## install SOPS
RUN wget  https://github.com/mozilla/sops/releases/download/v3.5.0/sops-v3.5.0.linux && \
    chmod +x sops-v3.5.0.linux && \
    mv sops-v3.5.0.linux  /usr/local/bin/sops

RUN git clone https://github.com/sstephenson/bats.git
RUN cd bats && ./install.sh /usr/local
## install kapp
RUN wget  https://github.com/k14s/kapp/releases/download/v0.35.0/kapp-linux-amd64 && \
    chmod +x kapp-linux-amd64  && \
    mv kapp-linux-amd64  /usr/local/bin/kapp

## install helmfile
RUN wget  https://github.com/roboll/helmfile/releases/download/v0.138.4/helmfile_linux_amd64 && \
    chmod +x helmfile_linux_amd64  && \
    mv helmfile_linux_amd64  /usr/local/bin/helmfile

## install korgi
RUN wget https://github.com/DataReply/korgi/releases/download/v0.0.7/korgi_0.0.7_Linux_x86_64 && \
    chmod +x korgi_0.0.7_Linux_x86_64 && \
    mv korgi_0.0.7_Linux_x86_64 /usr/local/bin/korgi

## install helm-plugins
RUN helm plugin install https://github.com/futuresimple/helm-secrets
RUN helm plugin install https://github.com/mumoshu/helm-x

RUN apk add -U gpgme

ADD https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz /tmp
RUN tar -zxvf /tmp/kustomize* -C /tmp \
  && mv /tmp/kustomize /bin/kustomize \
  && rm -rf /tmp/* \
  && chmod 0755 /bin/kustomize


RUN wget https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64 -O /usr/bin/yq &&\
    chmod +x /usr/bin/yq

ENTRYPOINT ["/usr/local/bin/korgi"]
