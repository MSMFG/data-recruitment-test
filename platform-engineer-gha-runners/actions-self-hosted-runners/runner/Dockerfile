# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# Download and verify the integrity of the download first

FROM ubuntu:22.04

# zscaler stuff if running locally
#COPY certs/ZscalerRootCertificate-2048-SHA256.crt /usr/local/share/ca-certificates/ZscalerRootCertificate-2048-SHA256.crt
#RUN apt-get update && apt-get install -y ca-certificates && update-ca-certificates
#ENV CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt \
#    REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt \
#    CLOUDSDK_CORE_CUSTOM_CA_CERTS_FILE=/etc/ssl/certs/ca-certificates.crt \
#    SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt \
#    HTTPLIB2_CA_CERTS=/etc/ssl/certs/ca-certificates.crt \
#    NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt
#RUN echo "ca_certificate=/etc/ssl/certs/ca-certificates.crt" >> /root/.wgetrc

RUN apt-get update && \
    apt-get -y install curl \
    iputils-ping \
    tar \
    jq

ARG GH_RUNNER_VERSION="2.301.1"
WORKDIR /runner
RUN curl -o actions.tar.gz --location "https://github.com/actions/runner/releases/download/v${GH_RUNNER_VERSION}/actions-runner-linux-x64-${GH_RUNNER_VERSION}.tar.gz" && \
    tar -zxf actions.tar.gz && \
    rm -f actions.tar.gz && \
    ./bin/installdependencies.sh

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

RUN useradd -m ghrunner && chown -R ghrunner: /runner
USER ghrunner
ENTRYPOINT ["/runner/entrypoint.sh"]
