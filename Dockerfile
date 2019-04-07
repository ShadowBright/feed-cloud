FROM debian:latest
MAINTAINER aplattner

env DEBIAN_FRONTEND noninteractive

USER root

# install dev tools
RUN apt-get update && \
    apt-get install -yq \ 
            curl \ 
            tar \
            vim \
            wget \
            python \
            python-pip \
            python-dev \
            libglib2.0-0 \
            libsm6 \ 
            libxrender1 \
            libfontconfig1 \
            libxtst6 \
            && \
            apt-get clean

ADD config/* /opt/
RUN chown root:root /opt/* \
    && chmod 700 /opt/*

ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh

RUN wget --quiet https://repo.continuum.io/miniconda/Miniconda-3.16.0-Linux-x86_64.sh && \
    /bin/bash Miniconda-3.16.0-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda-3.16.0-Linux-x86_64.sh && \
    /opt/conda/bin/conda install --yes conda==3.18.3 \
    && conda install --yes \
       'anaconda-client' \
       'numpy' \
       'pillow' \
       'BeautifulSoup4' \
       'nltk' \
       'matplotlib' \
       'feedparser' \
       'pyqt=4.11.4' \
       pyzmq \
       && conda clean -yt

RUN pip install wordcloud \
    && python -m nltk.downloader wordnet

WORKDIR /opt

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && apt-get autoremove
